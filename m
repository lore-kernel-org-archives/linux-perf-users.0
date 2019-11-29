From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 04/15] perf tools: Add map_groups to 'struct
 addr_location'
Date: Fri, 29 Nov 2019 14:40:56 +0100
Message-ID: <20191129134056.GE14169@krava>
References: <20191112183757.28660-1-acme@kernel.org>
 <20191112183757.28660-5-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112183757.28660-5-acme@kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Tue, Nov 12, 2019 at 03:37:46PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> From there we can get al->mg->machine, so replace that field with the
> more useful 'struct map_groups' that for now we're obtaining from
> al->map->groups, and that is one thing getting into the way of maps
> being fully shareable.
>=20
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lkml.kernel.org/n/tip-4qdducrm32tgrjupcp0kjh1e@git.kernel.o=
rg
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/callchain.c                          |  6 +++---
>  tools/perf/util/db-export.c                          | 12 ++++++------
>  tools/perf/util/event.c                              |  6 +++---
>  .../perf/util/scripting-engines/trace-event-python.c |  2 +-
>  tools/perf/util/symbol.h                             |  2 +-
>  5 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 9a9b56ed3f0a..89faa644b0bc 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1119,8 +1119,8 @@ int fill_callchain_info(struct addr_location *al, s=
truct callchain_cursor_node *
>  =09=09=09goto out;
>  =09}
> =20
> -=09if (al->map->groups =3D=3D &al->machine->kmaps) {
> -=09=09if (machine__is_host(al->machine)) {
> +=09if (al->mg =3D=3D &al->mg->machine->kmaps) {

heya, I'm getting segfault because of this change

perf record --call-graph dwarf ./ex

=09(gdb) r report --stdio
=09Program received signal SIGSEGV, Segmentation fault.
=09fill_callchain_info (al=3D0x7fffffffa1b0, node=3D0xcd2bd0, hide_unresolv=
ed=3Dfalse) at util/callchain.c:1122
=091122            if (al->maps =3D=3D &al->maps->machine->kmaps) {
=09(gdb) p al->maps
=09$1 =3D (struct maps *) 0x0

I wish all those map changes would go through some review,
I have no idea how the code works now ;-)

thanks,
jirka
