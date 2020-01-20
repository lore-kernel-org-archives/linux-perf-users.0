From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
Date: Mon, 20 Jan 2020 10:23:52 +0100
Message-ID: <20200120092352.GA608405@krava>
References: <20200108065844.4030-1-kjain@linux.ibm.com>
 <e866c12a-7328-8524-fd0e-668301da6875@linux.intel.com>
 <822bcb9d-4c08-39c5-e6e7-9c3e20d77852@linux.ibm.com>
 <20200108160249.GD402774@krava>
 <dde66abd-6025-31e3-9bda-a6eb1986eea8@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dde66abd-6025-31e3-9bda-a6eb1986eea8@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kajoljain <kjain@linux.ibm.com>
Cc: "Jin, Yao" <yao.jin@linux.intel.com>, acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Jan 20, 2020 at 02:23:19PM +0530, kajoljain wrote:
>=20
> On 1/8/20 9:32 PM, Jiri Olsa wrote:
> > On Wed, Jan 08, 2020 at 02:41:35PM +0530, kajoljain wrote:
> >=20
> > SNIP
> >=20
> > > > > -=A0=A0=A0 int i =3D 0;
> > > > > +=A0=A0=A0 int i =3D 0, j =3D 0;
> > > > >  =A0=A0=A0=A0=A0 bool leader_found;
> > > > >  =A0 =A0=A0=A0=A0=A0 evlist__for_each_entry (perf_evlist, ev) {
> > > > > +=A0=A0=A0=A0=A0=A0=A0 j++;
> > > > > +=A0=A0=A0=A0=A0=A0=A0 if (j <=3D iterator_perf_evlist)
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!strcmp(ev->name, ids[i])) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!metric_events[i])
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 metric_eve=
nts[i] =3D ev;
> > > > > @@ -146,6 +151,7 @@ static struct evsel *find_evsel_group(struc=
t
> > > > > evlist *perf_evlist,
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > >  =A0=A0=A0=A0=A0 }
> > > > > +=A0=A0=A0 iterator_perf_evlist =3D j;
> > > > >  =A0 =A0=A0=A0=A0=A0 return metric_events[0];
> > > > >  =A0 }
> > > > >=20
> > > > Thanks for reporting and fixing this issue.
> > > >=20
> > > > I just have one question, do we really need a *static variable* t=
o track
> > > > the matched events? Perhaps using an input parameter?
> > > Hi Jin,
> > >=20
> > > The other way I come up with to solve this issue is, making change =
in
> > > perf_evlist itself by adding some flag in event name, to keep track=
 of
> > > matched events.
> > >=20
> > > As if we change event name itself, next time when we compare it won=
't
> > > matched. But in that case we need to remove those flag later. Which=
 will
> > > increase the
> > >=20
> > > complexity. If you have any suggestions, please let me know.
> > we already keep evsel::cpu_iter for similar concept
> >=20
> > so I guess we could have some iterator_perf_evlist variable in evlist=
..
> > that is if we don't find other solution (other than static varable)
>=20
> Hi Jiri,
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 Thanks for reviewing the patch. I checked 'evs=
el::cpu_iter'
> variable, I think it added recently and I am not able to find any simil=
ar
> kind of variable in
>=20
> =A0=A0=A0 =A0=A0=A0=A0 evlist. Please let me know if my understanding i=
s fine. Do you want
> me to add new variable in evlist itself or there is any other way possi=
ble.

please check Arnaldo's tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core

jirka
