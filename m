From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [GIT PULL 00/35] perf/core improvements and fixes
Date: Wed, 15 Aug 2018 08:21:15 -0700
Message-ID: <BA2DD2BE-2EBB-415A-9171-8CC90F3E7F31@amacapital.net>
References: <20180815150611.32080-1-acme@kernel.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180815150611.32080-1-acme@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Kapshuk <alexander.kapshuk@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>, Benno Evers <bevers@mesosphere.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Ahern <dsahern@gmail.com>, Dongjiu Geng <gengdongjiu@huawei.com>, "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>, Joerg Roedel <joro@8bytes.org>
List-Id: linux-perf-users.vger.kernel.org


> On Aug 15, 2018, at 8:05 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wr=
ote:
>=20
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Hi Ingo,
>=20
>    Please consider pulling, this is on top of
> perf-core-for-mingo-4.19-20180809, that is not yet in tip.
>=20
> Thanks,
>=20
> - Arnaldo
>=20
> Test results at the end of this message, as usual.
>=20
> The following changes since commit 6a9405b56c274024564f9014bba97b92c91b34d=
6:
>=20
>  perf map: Optimize maps__fixup_overlappings() (2018-08-08 15:56:00 -0300)=

>=20
> are available in the Git repository at:
>=20
>  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-co=
re-for-mingo-4.19-20180815
>=20
> for you to fetch changes up to 6855dc41b24619c3d1de3dbd27dd0546b0e45272:
>=20
>  x86: Add entry trampolines to kcore

I don=E2=80=99t object per se, but once I finish rebasing and testing my ent=
ry trampoline removal code, this will probably have to go.=
