From: Arnaldo Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf tools: update docs regarding kernel/user space unwinding
Date: Fri, 27 Mar 2020 17:17:59 -0300
Message-ID: <C8021C4E-2764-47CE-AF79-10823C7FDBB2@gmail.com>
References: <20200325164053.10177-1-tonyj@suse.de> <38ba2caa-dadd-52c4-c6ea-5e01b7e59ee2@us.ibm.com> <20200327200934.GB2715@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200327200934.GB2715@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Jones <tonyj@suse.de>
Cc: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org



On March 27, 2020 5:09:34 PM GMT-03:00, Tony Jones <tonyj@suse=2Ede> wrote=
:
>On Thu, Mar 26, 2020 at 04:32:26PM -0500, Paul Clarke wrote:
>> > +		and 'lbr'=2E  The value 'dwarf' is effective only if libunwind
>> > +		(or a recent version of libdw) is present on the system;
>> > +		the value 'lbr' only works for certain cpus=2E The method for
>> > +		kernel space is controlled not by this option but by the
>> > +		kernel config (CONFIG_UNWINDER_*)=2E
>>=20
>> Your changes are just copying the old text, so this isn't a criticism
>of your patches=2E
>>=20
>> Do we have information to replace "a recent version of libdw", which
>will quickly get stale?
>
>Hi Paul=2E
>
>The original "(libunwind or a recent version of libdw)" text was from
>Feb 2016=2E   So a while ago=2E

Unfortunate wording, would be better to have the version where the require=
d feature was added to libdw=2E

>
>bd0419e2a5a9f requires >=3D 0=2E157 but this is for probing=2E  0a4f2b6a3=
ba50
>specifies >=3D 0=2E158 but I see no mention of=20
>why in the commit but since it's from 2014 and elfutils is now at
>0=2E178,  I think it's safe to just remove the=20
>reference=2E
>
>As an aside, there is a lot of detail in perf-config=2Etxt that's
>available in some of the other subcomands help files=2E
>Seems a good way for things to get stale=2E   It could also do with some
>grammatical cleanup=2E

English as a second language, many contributors, please consider sending f=
ixes, would be really appreciated,

Thanks,

- Arnaldo
>
>Tony

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
