From: Arnaldo Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf script: add flamegraph.py script
Date: Tue, 24 Mar 2020 18:26:29 -0300
Message-ID: <BCB65A54-D7A4-40DC-8862-B98422ED107B@gmail.com>
References: <20200320151355.66302-1-agerstmayr@redhat.com> <7176b535-f95b-bf6d-c181-6ccb91425f96@amd.com> <21c81775-876a-4dd2-f52f-42645963350f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <21c81775-876a-4dd2-f52f-42645963350f@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Gerstmayr <agerstmayr@redhat.com>, Kim Phillips <kim.phillips@amd.com>, linux-perf-users@vger.kernel.org
Cc: Martin Spier <mspier@netflix.com>, Brendan Gregg <bgregg@netflix.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org



On March 24, 2020 4:05:15 PM GMT-03:00, Andreas Gerstmayr <agerstmayr@redh=
at=2Ecom> wrote:
>On 24=2E03=2E20 17:16, Kim Phillips wrote:
>> On Ubuntu 19=2E10, where python 2=2E7 is still the default, I get:
>>=20
>> $ perf script report flamegraph
>>    File "/usr/libexec/perf-core/scripts/python/flamegraph=2Epy", line
>46
>>      print(f"Flame Graph template {self=2Eargs=2Etemplate} does not " +
>>                                                                 ^
>> SyntaxError: invalid syntax
>> Error running python script
>/usr/libexec/perf-core/scripts/python/flamegraph=2Epy
>>=20
>> Installing libpython3-dev doesn't help=2E
>
>Hmm, I was hoping that I can drop support for Python 2 in 2020 ;) (it's
>
>officially EOL since Jan 1, 2020)
>
>The Ubuntu 18=2E04 release notes mention that "Python 2 is no longer=20
>installed by default=2E Python 3 has been updated to 3=2E6=2E This is the
>last=20
>LTS release to include Python 2 in main=2E"=20
>(https://wiki=2Eubuntu=2Ecom/BionicBeaver/ReleaseNotes) - so imho it shou=
ld
>
>be fine to drop Python 2 support=2E
>
>I tested it with a Ubuntu VM, and by default the Python bindings aren't
>
>enabled in perf (see=20
>https://bugs=2Elaunchpad=2Enet/ubuntu/+source/linux/+bug/1707875)=2E
>
>But you can compile perf and select Python 3:
>
>$ make -j2 PYTHON=3Dpython3
>

I plan to make this the default soon=2E

- Arnaldo
>in the perf source directory (libpython3-dev must be installed)=2E
>
>
>Does this work for you?
>
>
>Cheers,
>Andreas

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
