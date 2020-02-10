From: Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH 2/3 v2] perf symbols: Update the list of kernel idle
 symbols
Date: Mon, 10 Feb 2020 18:52:17 +0000
Message-ID: <A3A96AB6-C21C-4F3D-A69C-C968D43195B2@fb.com>
References: <20200207230613.26709-1-kim.phillips@amd.com>
 <20200207230613.26709-2-kim.phillips@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200207230613.26709-2-kim.phillips@amd.com>
Content-Language: en-US
Content-ID: <49F800BADE5E8540B8ECEE84645D77FF@namprd15.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Phillips <kim.phillips@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org



> On Feb 7, 2020, at 3:06 PM, Kim Phillips <kim.phillips@amd.com> wrote:
>=20
> "acpi_idle_do_entry", "acpi_processor_ffh_cstate_enter", and "idle_cpu"
> appear in 'perf top' output, at least on AMD systems.
>=20
> Add them to perf's idle_symbols list, so they don't dominate 'perf top'
> output.
>=20
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Kim Phillips <kim.phillips@amd.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>

Acked-by: Song Liu <songliubraving@fb.com>
