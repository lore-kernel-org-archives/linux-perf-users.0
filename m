From: Konstantin Khlebnikov <koct9i@gmail.com>
Subject: Re: [PATCH] perf map: fix infinite loop on map_groups__fixup_overlappings
Date: Sat, 14 Dec 2019 14:16:21 +0300
Message-ID: <CALYGNiOtYgyCTAZn_Ti4wF+64a-mB=T9JdSb8+pyy7Aavq6Wfw@mail.gmail.com>
References: <20191211160734.18087-1-mmarchini@netflix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191211160734.18087-1-mmarchini@netflix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matheus Marchini <mmarchini@netflix.com>
Cc: linux-perf-users@vger.kernel.org, jkoch@netflix.com, =?UTF-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0g0JPQtdC90L3QsNC00YzQtdCy0LjRhyDQpdC70LXQsdC90LjQutC+?= =?UTF-8?B?0LI=?= <khlebnikov@yandex-team.ru>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Changbin Du <changbin.du@intel.com>, Song Liu <songliubraving@fb.com>, John Keeping <john@metanate.com>, Andi Kleen <ak@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Dec 11, 2019 at 7:10 PM Matheus Marchini <mmarchini@netflix.com> wrote:
>t
> In some cases, when using perf inject and there are JIT_CODE_MOVE
> records in the jitdump file, perf will end up in an infinite loop on
> map_groups__fixup_overlappings, which will keep allocating memory
> indefinitely. This issue was observed on Node.js (with changes to
> generate JIT_CODE_MOVE records) and on Java.

Could you show what it prints with -vv ?
I suppose map tree could be broken, like there is zero (or negative) size maps.

This should help to catch that

--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -848,13 +848,18 @@ static void __maps__insert(struct maps *maps,
struct map *map)
        const u64 ip = map->start;
        struct map *m;

+       assert((map->start < map->end) || !map->end);
+
        while (*p != NULL) {
                parent = *p;
                m = rb_entry(parent, struct map, rb_node);
-               if (ip < m->start)
+               if (ip < m->start) {
+                       assert(map->end <= m->start);
                        p = &(*p)->rb_left;
-               else
+               } else {
+                       assert(m->end <= map->start);
                        p = &(*p)->rb_right;
+               }
        }

        rb_link_node(&map->rb_node, parent, p);


>
> This issue started to occur after 6a9405b56c274 (perf map:
> Optimize maps__fixup_overlappings()). To prevent it from happening,
> partially revert those changes without losing the optimizations
> introduced in it.
>
> Signed-off-by: Matheus Marchini <mmarchini@netflix.com>
> ---
>  tools/perf/util/map.c | 17 +++++++++++++++++
>  tools/perf/util/map.h |  1 +
>  2 files changed, 18 insertions(+)
>
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 744bfbaf35cf..8918fdb8ddab 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -781,6 +781,21 @@ static void __map_groups__insert(struct map_groups *mg, struct map *map)
>         __maps__insert(&mg->maps, map);
>  }
>
> +int map__overlap(struct map *l, struct map *r)
> +{
> +       if (l->start > r->start) {
> +               struct map *t = l;
> +
> +               l = r;
> +               r = t;
> +       }
> +
> +       if (l->end > r->start)
> +               return 1;
> +
> +       return 0;
> +}
> +
>  int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE *fp)
>  {
>         struct maps *maps = &mg->maps;
> @@ -821,6 +836,8 @@ int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE
>                  */
>                 if (pos->start >= map->end)
>                         break;
> +               if (!map__overlap(map, pos))
> +                       continue;
>
>                 if (verbose >= 2) {
>
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index 5e8899883231..1383571437aa 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -132,6 +132,7 @@ static inline void __map__zput(struct map **map)
>
>  #define map__zput(map) __map__zput(&map)
>
> +int map__overlap(struct map *l, struct map *r);
>  size_t map__fprintf(struct map *map, FILE *fp);
>  size_t map__fprintf_dsoname(struct map *map, FILE *fp);
>  char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
> --
> 2.17.1
>
