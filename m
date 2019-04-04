From: Song Liu <songliubraving@fb.com>
Subject: Re: [BUG] perf: intel_pt won't display kernel function
Date: Thu, 4 Apr 2019 17:08:55 +0000
Message-ID: <678C87FF-A33E-477C-94C1-533026400B95@fb.com>
References: <20190403143738.GB32001@krava> <20190403145353.GE32553@kernel.org>
 <20190403151548.GF32553@kernel.org>
 <B07CAAC3-D085-443D-BB0C-05E9A8F3AFB2@fb.com>
 <20190403185053.GH32553@kernel.org>
 <124332A9-146A-446F-A82A-910C8319170E@fb.com>
 <425141B8-8908-4D48-90FD-8806BA9E9E12@fb.com>
 <A476B82A-4550-45F1-9A31-B1AA63C07489@fb.com> <20190404091438.GB31233@krava>
 <20190404122530.GC31233@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404122530.GC31233@krava>
Content-Language: en-US
Content-ID: <79B68D7AA593E54C907727DF2CAD93EB@namprd15.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <andi@firstfloor.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org



> On Apr 4, 2019, at 5:25 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Thu, Apr 04, 2019 at 11:14:38AM +0200, Jiri Olsa wrote:
>=20
> SNIP
>=20
>> Program received signal SIGABRT, Aborted.
>> 0x00007ffff75e60f5 in raise () from /lib64/libc.so.6
>> Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.6=
-29.fc30.x86_64 elfutils-libelf-0.176-1.fc30.x86_64 elfutils-libs-0.176-1.f=
c30.x86_64 libgcc-9.0.1-0.10.fc30.x86_64 libunwind-1.3.1-2.fc30.x86_64 libx=
crypt-4.4.4-2.fc30.x86_64 numactl-libs-2.0.12-2.fc30.x86_64 perl-libs-5.28.=
1-434.fc30.x86_64 python2-libs-2.7.16-1.fc30.x86_64 slang-2.3.2-5.fc30.x86_=
64 xz-libs-5.2.4-5.fc30.x86_64 zlib-1.2.11-15.fc30.x86_64
>> (gdb) bt
>> #0  0x00007ffff75e60f5 in raise () from /lib64/libc.so.6
>> #1  0x00007ffff75d0895 in abort () from /lib64/libc.so.6
>> #2  0x00007ffff75d0769 in __assert_fail_base.cold () from /lib64/libc.so=
.6
>> #3  0x00007ffff75de596 in __assert_fail () from /lib64/libc.so.6
>> #4  0x00000000004fc006 in refcount_sub_and_test (i=3D1, r=3D0x1224e88) a=
t /home/jolsa/linux/tools/include/linux/refcount.h:131
>> #5  refcount_dec_and_test (r=3D0x1224e88) at /home/jolsa/linux/tools/inc=
lude/linux/refcount.h:148
>> #6  map__put (map=3D0x1224df0) at util/map.c:299
>> #7  0x00000000004fdb95 in __maps__remove (map=3D0x1224df0, maps=3D0xb17d=
80) at util/map.c:953
>> #8  maps__remove (maps=3D0xb17d80, map=3D0x1224df0) at util/map.c:959
>> #9  0x00000000004f7d8a in map_groups__remove (map=3D<optimized out>, mg=
=3D<optimized out>) at util/map_groups.h:65
>> #10 machine__process_ksymbol_unregister (sample=3D<optimized out>, event=
=3D0x7ffff7279670, machine=3D<optimized out>) at util/machine.c:728
>> #11 machine__process_ksymbol (machine=3D<optimized out>, event=3D0x7ffff=
7279670, sample=3D<optimized out>) at util/machine.c:741
>> #12 0x00000000004fffbb in perf_session__deliver_event (session=3D0xb1139=
0, event=3D0x7ffff7279670, tool=3D0x7fffffffc7b0, file_offset=3D13936) at u=
til/session.c:1362
>> #13 0x00000000005039bb in do_flush (show_progress=3Dfalse, oe=3D0xb17e80=
) at util/ordered-events.c:243
>> #14 __ordered_events__flush (oe=3D0xb17e80, how=3DOE_FLUSH__ROUND, times=
tamp=3D<optimized out>) at util/ordered-events.c:322
>> #15 0x00000000005005e4 in perf_session__process_user_event (session=3Dse=
ssion@entry=3D0xb11390, event=3Devent@entry=3D0x7ffff72a4af8,
>>    file_offset=3Dfile_offset@entry=3D191224) at util/session.c:1402
>> #16 0x000000000050091e in perf_session__process_event (file_offset=3D191=
224, event=3D0x7ffff72a4af8, session=3D0xb11390) at util/session.c:1529
>> #17 process_simple (session=3Dsession@entry=3D0xb11390, event=3Devent@en=
try=3D0x7ffff72a4af8, file_offset=3Dfile_offset@entry=3D191224) at util/ses=
sion.c:1962
>> #18 0x0000000000501f44 in reader__process_events (prog=3D0x7fffffffc680,=
 session=3D0xb11390, rd=3D<synthetic pointer>) at util/session.c:1931
>> #19 __perf_session__process_events (session=3D0xb11390) at util/session.=
c:1985
>> #20 perf_session__process_events (session=3D0xb11390) at util/session.c:=
2018
>> #21 0x000000000045bb42 in __cmd_script (script=3D0x7fffffffc7b0) at buil=
tin-script.c:2429
>> #22 cmd_script (argc=3D<optimized out>, argv=3D<optimized out>) at built=
in-script.c:3770
>> #23 0x00000000004a65cb in run_builtin (p=3Dp@entry=3D0x994918 <commands+=
408>, argc=3Dargc@entry=3D4, argv=3Dargv@entry=3D0x7fffffffe160) at perf.c:=
303
>> #24 0x000000000042da1e in handle_internal_command (argv=3D0x7fffffffe160=
, argc=3D4) at perf.c:355
>> #25 run_argv (argcp=3D<synthetic pointer>, argv=3D<synthetic pointer>) a=
t perf.c:399
>> #26 main (argc=3D4, argv=3D0x7fffffffe160) at perf.c:521
>=20

For some reason, I cannot repro this issue. I tried to load two
bpf programs with same name, but that doesn't trigger it either.=20


>=20
> we dont increase the map's reference for same name,
> which we need to.. I assume we we re able to hit this
> path with bpf maps/dso with same name
>=20
> jirka

Does the following change fix the issue on your side?

Thanks,
Song

>=20
>=20
> ---
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 58ae5fc1f0e9..cdc49113ba38 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -929,10 +929,11 @@ static void __maps__insert_name(struct maps *maps, =
struct map *map)
> 		else if (rc  > 0)
> 			p =3D &(*p)->rb_right;
> 		else
> -			return;
> +			goto out;
> 	}
> 	rb_link_node(&map->rb_node_name, parent, p);
> 	rb_insert_color(&map->rb_node_name, &maps->names);
> +out:
> 	map__get(map);
> }
>=20
