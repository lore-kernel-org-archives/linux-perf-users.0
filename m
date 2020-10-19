From: Stanislav Ivanichkin <sivanichkin@yandex-team.ru>
Subject: Re: [PATCH] perf trace: Segfault when trying to trace events by
 cgroup
Date: Mon, 19 Oct 2020 10:43:42 +0300
Message-ID: <6A368965-ACB4-47CD-902C-0B910F6BEEE9@yandex-team.ru>
References: <20201009064547.62047-1-sivanichkin@yandex-team.ru>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20201009064547.62047-1-sivanichkin@yandex-team.ru>
To: linux-kernel@vger.kernel.org
Cc: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Hi,

+linux-perf-users@

Gentle ping for this patch

Many Thanks

--
Stanislav Ivanichkin

> On 9 Oct 2020, at 09:45, Stanislav Ivanichkin =
<sivanichkin@yandex-team.ru> wrote:
>=20
> # ./perf trace -e sched:sched_switch -G test -a sleep 1
> perf: Segmentation fault
> Obtained 11 stack frames.
> ./perf(sighandler_dump_stack+0x43) [0x55cfdc636db3]
> /lib/x86_64-linux-gnu/libc.so.6(+0x3efcf) [0x7fd23eecafcf]
> ./perf(parse_cgroups+0x36) [0x55cfdc673f36]
> ./perf(+0x3186ed) [0x55cfdc70d6ed]
> ./perf(parse_options_subcommand+0x629) [0x55cfdc70e999]
> ./perf(cmd_trace+0x9c2) [0x55cfdc5ad6d2]
> ./perf(+0x1e8ae0) [0x55cfdc5ddae0]
> ./perf(+0x1e8ded) [0x55cfdc5ddded]
> ./perf(main+0x370) [0x55cfdc556f00]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe6) =
[0x7fd23eeadb96]
> ./perf(_start+0x29) [0x55cfdc557389]
> Segmentation fault
>=20
> It happens because "struct trace" in option->value is passed to
> parse_cgroups function instead of "struct evlist".
>=20
> Signed-off-by: Stanislav Ivanichkin <sivanichkin@yandex-team.ru>
> Reviewed-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> ---
> tools/perf/builtin-trace.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index bea461b6f937..cbc4de6840db 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4651,9 +4651,12 @@ static int trace__parse_cgroups(const struct =
option *opt, const char *str, int u
> {
> 	struct trace *trace =3D opt->value;
>=20
> -	if (!list_empty(&trace->evlist->core.entries))
> -		return parse_cgroups(opt, str, unset);
> -
> +	if (!list_empty(&trace->evlist->core.entries)) {
> +		struct option o =3D OPT_CALLBACK('G', "cgroup", =
&trace->evlist,
> +			"name", "monitor event in cgroup name only",
> +			parse_cgroups);
> +		return parse_cgroups(&o, str, unset);
> +	}
> 	trace->cgroup =3D evlist__findnew_cgroup(trace->evlist, str);
>=20
> 	return 0;
> --=20
> 2.17.1
>=20
