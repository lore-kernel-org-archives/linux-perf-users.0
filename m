Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B06167DB3
	for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972228; cv=none; b=EuCYTZVitEs9MC0xnFxq9ZRf4fYqIRD8pAwkmzLrSugMJCR4yuXNMsAhgjub+nAvCXs0+N/Xr23l5YzXJkjpZ8BM9gaZt9QVpfvVCcxE9OGdOEGO3Xd9fMwi66BrYRMNN9YWMm7ivxISF8OFBT5W1vILsBBjtJojup/gHdV8oRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972228; c=relaxed/simple;
	bh=+D60/67Z3oSYOwoY1r8yrLb+a4d8fM/uvJ73OwOpaBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oBI4GDKBQuMbHeWNDaeGeNr3xPb7MdYiBHaeBLQvVa26V6xmzDUB5OijILsI8D5yG4L6HPOlIcfHOwNnAGCQRVgk5HyQEBwTxK0vqaVD/OjZ+v0VC6KanmM8Ud4n9ZCV32hgHEtK5WtQE5w5TBKHML5J3kpgnj2pC3XcThofDaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2493E2F4;
	Wed, 29 May 2024 01:34:26 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92F9C3F762;
	Wed, 29 May 2024 01:34:01 -0700 (PDT)
Message-ID: <71e641b5-6b58-40fd-8d6e-eefcad049380@arm.com>
Date: Wed, 29 May 2024 09:34:03 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why does libtracevent pkg-config detection wipe PKG_CONFIG_PATH?
To: Mateusz Kowalczyk <fuuzetsu@fuuzetsu.co.uk>,
 linux-perf-users <linux-perf-users@vger.kernel.org>
References: <cfcaf804-d7b1-4d55-8465-12e1d238aca1@app.fastmail.com>
 <0e2d8cc4-420b-4387-9b26-2f00cbbc1a83@arm.com>
 <198bd01f-ffa5-4f9e-9c03-a1193eec25e4@app.fastmail.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <198bd01f-ffa5-4f9e-9c03-a1193eec25e4@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 29/05/2024 01:05, Mateusz Kowalczyk wrote:
> On Wed, 29 May 2024, at 1:09 AM, James Clark wrote:
>> On 27/05/2024 01:56, Mateusz Kowalczyk wrote:
>>> Hi,
>>>
>>> To build recent perf, I'm having to apply the below patch.
>>>
>>> ```diff
>>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>>> index 7f1e016a9253..b70fef12a977 100644
>>> --- a/tools/perf/Makefile.config
>>> +++ b/tools/perf/Makefile.config
>>> @@ -1181,7 +1181,7 @@ ifneq ($(NO_LIBTRACEEVENT),1)
>>>      CFLAGS +=3D -DHAVE_LIBTRACEEVENT $(LIBTRACEEVENT_CFLAGS)
>>>      LDFLAGS +=3D $(LIBTRACEEVENT_LDFLAGS)
>>>      EXTLIBS +=3D ${TRACEEVENTLIBS}
>>> -    LIBTRACEEVENT_VERSION :=3D $(shell PKG_CONFIG_PATH=3D$(LIBTRACEE=
VENT_DIR) $(PKG_CONFIG) --modversion libtraceevent)
>>> +    LIBTRACEEVENT_VERSION :=3D $(shell $(PKG_CONFIG) --modversion li=
btraceevent)
>>>      LIBTRACEEVENT_VERSION_1 :=3D $(word 1, $(subst ., ,$(LIBTRACEEVE=
NT_VERSION)))
>>>      LIBTRACEEVENT_VERSION_2 :=3D $(word 2, $(subst ., ,$(LIBTRACEEVE=
NT_VERSION)))
>>>      LIBTRACEEVENT_VERSION_3 :=3D $(word 3, $(subst ., ,$(LIBTRACEEVE=
NT_VERSION)))
>>> ```
>>>
>>> I don't understand why `PKG_CONFIG_PATH` is overwritten this way. `gr=
ep`ing for PKG_CONFIG_PATH reveals that this isn't done anywhere else in =
the kernel tree. All other uses of `$(PKG_CONFIG)` in the file simply inv=
oke the tool.
>>>
>>
>> Hi Mateusz,
>>
>> If PKG_CONFIG_PATH being overwritten is an issue, I'm assuming that yo=
u
>> have it set in your shell already? Is there a reason you aren't using
>> the default? Or is it that your version of pkg-config doesn't like tha=
t
>> var being set to an empty value?
>=20
> I have PKG_CONFIG_PATH set in my shell already. I don't have LIBTRACEEV=
ENT_DIR set.
>=20
> I'm not sure if pkg-config version is relevant, presumably if PKG_CONFI=
G_PATH is empty then no matter the version, it'll fail to resolve anythin=
g? Maybe not. Either way, on my setup, PKG_CONFIG_PATH is set explicitly =
and libtraceevent.pc is on it.
>=20
> ```
> [shana@aya:~/programming/linux/tools/perf]$ echo $PKG_CONFIG_PATH=20
> /nix/store/k3701zl6gmx3la7y4dnflcvf3xfy88kh-python3-3.11.9/lib/pkgconfi=
g:/nix/store/azfzvr6qa3680a8prh3xrpjfr26zmm59-libxslt-1.1.39-dev/lib/pkgc=
onfig:/nix/store/z91sa53zd8iscw7bsjphdk8s5b84hwpg-audit-3.1.2-dev/lib/pkg=
config:/nix/store/zk3sjrzfyjw14yy8jq9yn9nk41clf84q-elfutils-0.191-dev/lib=
/pkgconfig:/nix/store/hf0v7fphfvxrz8dvgv2fxh12vslwh9hs-newt-0.52.24/lib/p=
kgconfig:/nix/store/gms9ygkqyhw74nrhxqcm0xf2gpnqbpss-slang-2.3.3-dev/lib/=
pkgconfig:/nix/store/2nj2qa56cnq6shqskd9ixipc01s302wb-ncurses-6.4-dev/lib=
/pkgconfig:/nix/store/i4w2yc2np0lw8plxri2s2n244ywm1wfy-libtraceevent-1.8.=
2-dev/lib/pkgconfig:/nix/store/m35h4lw1sslg0vdqw0bjkcx5nqlv4pl2-libunwind=
-1.8.1-dev/lib/pkgconfig:/nix/store/j93y8jkrqjy18njpnszvsk792hn1vd89-xz-5=
=2E4.6-dev/lib/pkgconfig:/nix/store/wz1lmhhmvjxj2ipp2z5mvkydchhljggm-zlib=
-1.3.1-dev/lib/pkgconfig:/nix/store/0bp9inq3wd4car25n60idlfics6fajjv-open=
ssl-3.0.13-dev/lib/pkgconfig:/nix/store/6a5ryz1dbq8n79qkgcvikgm3c4fmkp05-=
numactl-2.0.18-dev/lib/pkgconfig:/nix/store/wwg6376ymkhpjxy6c3w9gkbhv6l2g=
mqy-libxcrypt-4.4.36/lib/pkgconfig:/nix/store/ijj4lm5k5vg7fzf3w3cbpgfc98d=
1b01a-babeltrace-1.5.8/lib/pkgconfig:/nix/store/z2jqrpg85lkh7v9bpz24nsmac=
1lhs5bs-zstd-1.5.6-dev/lib/pkgconfig:/nix/store/j3hdndafs2ixbh1bhv95g6pj4=
bankd1i-libcap-2.69-dev/lib/pkgconfig:/nix/store/srmzd01br39m4w52v9zb66v4=
ghlxsxfg-attr-2.5.2-dev/lib/pkgconfig
>=20
> [shana@aya:~/programming/linux/tools/perf]$ pkg-config --version
> 0.29.2
> ```
>=20
>>> Of course, I do actually have `libtraceevent.pc` available, it's just=
 that `LIBTRACEVENT_DIR` is empty which stops it from finding it.
>>>
>>> ```
>>> [shana@aya:~/programming/linux/tools/perf]$ pkg-config --modversion l=
ibtraceevent
>>> 1.8.2
>>> ```
>>>
>>> If I do not apply the patch, I'm getting the below errors during buil=
d.
>>>
>>> I'm not sure how others are getting it to build, maybe I'm doing some=
thing wrong? Please let me know. If the diff is fine, it'd be great if an=
yone could apply it.
>>>
>>
>> I think your diff needs a small change. I'm assuming it was done this
>> way to allow the custom libtraceevent path to be specified with
>> LIBTRACEEVENT_DIR. If you remove that then it can't be done anymore.
>>
>> Isn't the right change to set PKG_CONFIG_PATH if LIBTRACEEVENT_DIR is
>> set, but otherwise leave it unset?
>=20
> I think that sounds right. I'm not sure what that looks like in `Make` =
but if no-one is up to making the change, I can attempt it at least...
>=20

Give it a go. It's probably something like this:

  trace_cfg_path :=3D $(if
    $(LIBTRACEEVENT_DIR),$(LIBTRACEEVENT_DIR),$(PKG_CONFIG_PATH))
  $(shell PKG_CONFIG_PATH=3D$(trace_cfg_path) $(PKG_CONFIG) ...

Don't forget to check the patch guide:
https://docs.kernel.org/process/submitting-patches.html

>> But yes the build is working fine for me.
>=20
> How does it work? Presumably you either must have LIBTRACEEVENT_DIR set=
 or your pkg-config is able to find libraries even with empty PKG_CONFIG_=
PATH. The latter would explain some things. On my setup at least, there a=
re no "global" default search locations and PKG_CONFIG_PATH basically det=
ermines all the library locations. Maybe that's the difference. I guess i=
t's easy to verify, if you run `PKG_CONFIG_PATH=3D pkg-config --modversio=
n libtraceevent` then I must assume that it returns something on your set=
up.
>=20

Yes I'm using the default paths so I don't need to set anything, and I
assume most people are. It all makes sense that you are seeing the issue
if you are setting it.

>> James
>>
>>
>>> Thanks!
>>>
>>> ```
>>> Perhaps you should add the directory containing `libtraceevent.pc'
>>> to the PKG_CONFIG_PATH environment variable
>>> No package 'libtraceevent' found
>>> expr: syntax error: unexpected argument =E2=80=98255=E2=80=99
>>>
>>> Auto-detecting system features:
>>> ...                                   dwarf: [ on  ]
>>> ...                      dwarf_getlocations: [ on  ]
>>> ...                                   glibc: [ on  ]
>>> ...                                  libbfd: [ on  ]
>>> ...                          libbfd-buildid: [ on  ]
>>> ...                                  libcap: [ on  ]
>>> ...                                  libelf: [ on  ]
>>> ...                                 libnuma: [ on  ]
>>> ...                  numa_num_possible_cpus: [ on  ]
>>> ...                                 libperl: [ on  ]
>>> ...                               libpython: [ on  ]
>>> ...                               libcrypto: [ on  ]
>>> ...                               libunwind: [ on  ]
>>> ...                      libdw-dwarf-unwind: [ on  ]
>>> ...                             libcapstone: [ OFF ]
>>> ...                                    zlib: [ on  ]
>>> ...                                    lzma: [ on  ]
>>> ...                               get_cpuid: [ on  ]
>>> ...                                     bpf: [ on  ]
>>> ...                                  libaio: [ on  ]
>>> ...                                 libzstd: [ on  ]
>>>
>>>   INSTALL libsubcmd_headers
>>>   PERF_VERSION =3D 6.10.rc1.g1613e604df0c
>>>   GEN     perf-archive
>>>   GEN     perf-iostat
>>>   INSTALL libsymbol_headers
>>>   INSTALL libapi_headers
>>>   INSTALL libperf_headers
>>>   INSTALL libbpf_headers
>>>   TEST    pmu-events/metric_test.log
>>>   CC      builtin-bench.o
>>>   CC      builtin-annotate.o
>>>   CC      builtin-config.o
>>>   CC      builtin-diff.o
>>>   CC      builtin-evlist.o
>>>   CC      builtin-ftrace.o
>>>   CC      builtin-help.o
>>>   CC      builtin-buildid-list.o
>>>   CC      builtin-buildid-cache.o
>>>   CC      builtin-kallsyms.o
>>>   CC      builtin-list.o
>>>   GEN     pmu-events/pmu-events.c
>>> In file included from util/session.h:5,
>>>                  from builtin-buildid-list.c:17:
>>> util/trace-event.h:152:62: error: operator '&&' has no right operand
>>>   152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION =
>=3D MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>>>       |                                                              =
^~
>>> In file included from util/session.h:5,
>>>                  from builtin-evlist.c:15:
>>> util/trace-event.h:152:62: error: operator '&&' has no right operand
>>>   152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION =
>=3D MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>>>       |                                                              =
^~
>>> In file included from util/session.h:5,
>>>                  from builtin-buildid-cache.c:24:
>>> util/trace-event.h:152:62: error: operator '&&' has no right operand
>>>   152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION =
>=3D MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>>>       |                                                              =
^~
>>>   CC      builtin-record.o
>>> In file included from util/session.h:5,
>>>                  from builtin-diff.c:15:
>>> util/trace-event.h:152:62: error: operator '&&' has no right operand
>>>   152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION =
>=3D MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>>>       |                                                              =
^~
>>>   CC      builtin-report.o
>>>   CC      builtin-stat.o
>>> make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.buil=
d:105: builtin-buildid-list.o] Error 1
>>> make[3]: *** Waiting for unfinished jobs....
>>> make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.buil=
d:105: builtin-evlist.o] Error 1
>>> In file included from util/session.h:5,
>>>                  from builtin-annotate.c:32:
>>> util/trace-event.h:152:62: error: operator '&&' has no right operand
>>>   152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION =
>=3D MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>>>       |                                                              =
^~
>>> make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.buil=
d:105: builtin-buildid-cache.o] Error 1
>>> make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.buil=
d:105: builtin-annotate.o] Error 1
>>> make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.buil=
d:105: builtin-diff.o] Error 1
>>> In file included from util/session.h:5,
>>>                  from builtin-record.c:27:
>>> util/trace-event.h:152:62: error: operator '&&' has no right operand
>>>   152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION =
>=3D MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>>>       |                                                              =
^~
>>> In file included from util/session.h:5,
>>>                  from builtin-stat.c:60:
>>> util/trace-event.h:152:62: error: operator '&&' has no right operand
>>>   152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION =
>=3D MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>>>       |                                                              =
^~
>>> In file included from util/session.h:5,
>>>                  from builtin-report.c:35:
>>> util/trace-event.h:152:62: error: operator '&&' has no right operand
>>>   152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION =
>=3D MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>>>       |                                                              =
^~
>>> make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.buil=
d:105: builtin-record.o] Error 1
>>> make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.buil=
d:105: builtin-report.o] Error 1
>>> make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.buil=
d:105: builtin-stat.o] Error 1
>>> make[2]: *** [Makefile.perf:727: perf-in.o] Error 2
>>> make[2]: *** Waiting for unfinished jobs....
>>>   CC      pmu-events/pmu-events.o
>>>   LD      pmu-events/pmu-events-in.o
>>> make[1]: *** [Makefile.perf:264: sub-make] Error 2
>>> make: *** [Makefile:70: all] Error 2
>>> perf version 6.10.rc1.g5f00d82dec63
>>>
>>> ```
>>>
>>> --
>>> Mateusz K.
>=20
> Thanks!
>=20
> --
> Mateusz K
