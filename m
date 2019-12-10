From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf top for arm64?
Date: Tue, 10 Dec 2019 18:08:41 +0100
Message-ID: <20191210170841.GA23357@krava>
References: <1573045254-39833-1-git-send-email-john.garry@huawei.com>
 <20191106140036.GA6259@kernel.org>
 <418023e7-a50d-cb6f-989f-2e6d114ce5d8@huawei.com>
 <20191210163655.GG14123@krava>
 <952dc484-2739-ee65-f41c-f0198850ab10@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <952dc484-2739-ee65-f41c-f0198850ab10@huawei.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, namhyung@kernel.org, mark.rutland@arm.com, will@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linuxarm <linuxarm@huawei.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Tue, Dec 10, 2019 at 04:52:52PM +0000, John Garry wrote:
> On 10/12/2019 16:36, Jiri Olsa wrote:
> > On Tue, Dec 10, 2019 at 04:13:49PM +0000, John Garry wrote:
> > > Hi all,
> > >=20
> > > I find to my surprise that "perf top" does not work for arm64:
> > >=20
> > > root@ubuntu:/home/john/linux# tools/perf/perf top
> > > Couldn't read the cpuid for this machine: No such file or directory
> >=20
>=20
> Hi Jirka,
>=20
> > there was recent change that check on cpuid and quits:
> >    608127f73779 perf top: Initialize perf_env->cpuid, needed by the per=
 arch annotation init routine
> >=20
>=20
> ok, this is new code. I obviously didn't check the git history...
>=20
> But, apart from this, there are many other places where get_cpuid() is
> called. I wonder what else we're missing out on, and whether we should st=
ill
> add it.

right, I was just wondering how come vendor events are working for you,
but realized we have get_cpuid_str being called in there ;-)

I think we should add it as you have it prepared already,
could you post it with bigger changelog that would explain
where it's being used for arm?

jirka
