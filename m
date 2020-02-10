From: Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH 1/3 v2] perf stat: don't report a null stalled cycles per
 insn metric
Date: Mon, 10 Feb 2020 18:53:20 +0000
Message-ID: <D2E25104-C81C-4DF5-B781-E3F839AD3836@fb.com>
References: <20200207230613.26709-1-kim.phillips@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200207230613.26709-1-kim.phillips@amd.com>
Content-Language: en-US
Content-ID: <A460C3E55A7C0F46AE87A9BCB62DA9A3@namprd15.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Phillips <kim.phillips@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org



> On Feb 7, 2020, at 3:06 PM, Kim Phillips <kim.phillips@amd.com> wrote:
>=20
> For data collected on machines with front end stalled cycles supported,
> such as found on modern AMD CPU families, commit 146540fb545b ("perf
> stat: Always separate stalled cycles per insn") introduces a new line
> in CSV output with a leading comma that upsets some automated scripts.
> Scripts have to use "-e ex_ret_instr" to work around this issue, after
> upgrading to a version of perf with that commit.
>=20
> We could add "if (have_frontend_stalled && !config->csv_sep)"
> to the not (total && avg) else clause, to emphasize that CSV users
> are usually scripts, and are written to do only what is needed, i.e.,
> they wouldn't typically invoke "perf stat" without specifying an
> explicit event list.
>=20
> But - let alone CSV output - why should users now tolerate a constant
> 0-reporting extra line in regular terminal output?:
>=20
> BEFORE:
>=20
> $ sudo perf stat --all-cpus -einstructions,cycles -- sleep 1
>=20
> Performance counter stats for 'system wide':
>=20
>       181,110,981      instructions              #    0.58  insn per cycl=
e
>                                                  #    0.00  stalled cycle=
s per insn
>       309,876,469      cycles
>=20
>       1.002202582 seconds time elapsed
>=20
> The user would not like to see the now permanent
> "0.00  stalled cycles per insn" line fixture, as it gives
> no useful information.
>=20
> So this patch removes the printing of the zeroed stalled cycles
> line altogether, almost reverting the very original commit fb4605ba47e7
> ("perf stat: Check for frontend stalled for metrics"), which seems
> like it was written to normalize --metric-only column output
> of common Intel machines at the time: modern Intel machines
> have ceased to support the genericised frontend stalled metrics AFAICT.
>=20
> AFTER:
>=20
> $ sudo perf stat --all-cpus -einstructions,cycles -- sleep 1
>=20
> Performance counter stats for 'system wide':
>=20
>       244,071,432      instructions              #    0.69  insn per cycl=
e
>       355,353,490      cycles
>=20
>       1.001862516 seconds time elapsed
>=20
> Output behaviour when stalled cycles is indeed measured is not affected
> (BEFORE =3D=3D AFTER):
>=20
> $ sudo perf stat --all-cpus -einstructions,cycles,stalled-cycles-frontend=
 -- sleep 1
>=20
> Performance counter stats for 'system wide':
>=20
>       247,227,799      instructions              #    0.63  insn per cycl=
e
>                                                  #    0.26  stalled cycle=
s per insn
>       394,745,636      cycles
>        63,194,485      stalled-cycles-frontend   #   16.01% frontend cycl=
es idle
>=20
>       1.002079770 seconds time elapsed
>=20
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Kim Phillips <kim.phillips@amd.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Fixes: 146540fb545b ("perf stat: Always separate stalled cycles per insn"=
)
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>

Acked-by: Song Liu <songliubraving@fb.com>

Thanks for improving perf on AMD systems! =
