Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793851092;
	b=u+g7O+oBxxyG4v/M6lJe5v++KhPz836YjbjaRr8pQWl0Xwny20qO65x7xRSUodorBRJW
	 yG5TkaGWX8qr6g2+Wr3AjHKdEagTaa7dREenfXAW8OUGn51qfQduhP3vduK8DRxBXU3PQ
	 hbDFNvxLNDExDaKhczOLspdaMjhtNH+UtUGEQ2RVSuj83BjiJaKB4qCThMnzk0/GXB14Z
	 QnfXa5sz9N52fNpztS55W/6mShjdtum2sdd77nw5jEKYN5ij2veQPSxYmg6c5YE9asvD3
	 JhRphg+0flvonn8wIEoLiBnTZLsRCFWKSrLFROytaKYyA9WX5qwDB4k81Fm3hFHDvhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ep++7+yqx3z3neXmWb1Nk7vsZAtV36tjaGvf93hHL8g=;
	b=oApTVXypbjR0zDj15mGbGqYBd//PWmXmC55W1XXjQnoZXY3h7pC4AF8T/PltHoroc9ED
	 GjZmFpRKojES0k4I3WB0rUOYZBdkmBjArsgkKbCYM2YDegL6L2j1yHuRxjloNeLso12T9
	 EGpLoyi7qoZYqxl21XE2E6DkjvAVHlotSeCTRyFSwn1v/cJoPcQW663jfr8IAGRA9PXG1
	 58r+RvWxGQ/UAOsVG8rybFBOjOC98N2qGCa7ycNHQ5rtXPL8XM8ky4JOwjuebomOuKmug
	 1pxA8VifdOI+hrUSeCX/hRSHgENYrqG0glCBcGUsez1YTnMWNmZpHLoE6HdQmWBBaAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ht5Xe0wk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84251606A32F
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 03:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84251606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ht5Xe0wk
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-533202fe429so163031cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 19:58:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793851090; cv=none;
        d=google.com; s=arc-20260327;
        b=bO/9fmMaYQxAq6l1ZzOXZBMMvbuzR7dedRfE1t5gy2wYcHKbYDWijCHrXGLGHjJVNg
         ufs3NJ0G0HP92x4HEtn8EaoFm6IQ8XkQEOkrK8kKDK0B4TGSkl+EuC++L9xiNkgl67y+
         dh9WyG80Zk/Ex0O3VtMa7gLjRYWDv87OgWS+tuMvDb1yTGVpqUmtBrjcW36uZ8WlUrty
         PRuNn+vJYUIbBbn+4UQG0eD7vccOtErXbcP4PjY1N81QlGqBlBniYQLbUa0AZBkmvyL7
         LTBrDFmmQz68IGepeeGnMGF1ZU+YKgzDGARoDzvAZ0GO9n/Z9NS3qUY2LBCAvn7Vi4uD
         3zrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ep++7+yqx3z3neXmWb1Nk7vsZAtV36tjaGvf93hHL8g=;
        fh=A5d2bmRI66uUdz6WKgeT3rgyJTPQbnmXWf7vEBPLAmo=;
        b=Jqsmp8yRq298L5COq/lNDmsT5s3PkFGG4D+9cTE7ds3NfgXIYe+AOjmoe2HJe8WoZN
         ngAebu1kpz7gIig6WKfJeVPpyjGCGLRITF4paAELctJWvxP9fnqUs72VLaQxcy0hw06E
         Vm9wP/PaSI4pwnZrTkl3pAC3W7p6qST0bXzSCZtX604gfMtNDSJLGE2Su4yBoe21zEzw
         /QroXyZJDc74xPps5p6xUMGcvEhTKmhYuraCsG1jWOOQUpRaHHAsqIWQ1vSONh2IKIni
         C4YC5A+8w8YmXUsbIoR/yp+qBE1N2qvur6GtOLofORMHLfet3awUN1KMisjBp5UuUeaz
         8LUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793851090; x=1794455890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ep++7+yqx3z3neXmWb1Nk7vsZAtV36tjaGvf93hHL8g=;
        b=ht5Xe0wkWXoadZQbiKuAIp9T6s/a1Y0gAD5nEVXXSjbYFepgrkxfMO7n2wtRLUuRwf
         vxX9wpYxwCJmEM7KZY6rJp+vg4TIBxhSVYXh2PaWWTlVjIRJqJOOuwpayQczq91yEJur
         FnuUyS6iQyjOAVWifiKXvHD4MVMithkjG5BUKGfcQoMC5oUGr10tEGCKw3D4/AxSflt9
         tLV388cNsXEtKnpw5AHy4b1Zn4bmVPU09FVFrZLCVzximM5Mv5ilSuCcF1dJiCEOWzQ+
         5l4AM0BN9TgSVMF5+zYmNE9pPOBw5tPIxuxiFhHpB8lKHIwutCBwO/88fZZponBoFtrc
         GEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793851090; x=1794455890;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ep++7+yqx3z3neXmWb1Nk7vsZAtV36tjaGvf93hHL8g=;
        b=G3GvkbV9jfJRFClkesced+k2SAzJO037xUXLclC4FiO5tNl5b5uRG3Hm9nVCg7hYXY
         rx7vh8/f1U3Vx8suxsVEO6f7dcFDrV4fK4bFKSnXEVhBImTv2agqWMCuugFfggkGtQYy
         uiu4jMWWjPqEpmuh0I7ryQDdZs6FAJxhir9LTRaD5d+YXFYRsxzNvDAMO+kDAFEHJa9T
         PTYFAc1bRKk/4NmEO16FzQECmls4yqp/NYKw5SvagJxTtsy38j00Er+nXoyqH0xme8Cu
         McCc/kApKsV6jcVEloKZr9TWU0lM16lbzhPRNu8c7dUaO9q2kEfaQ6VMOLn0ByJBCWCR
         o4kQ==
X-Forwarded-Encrypted: i=1; AKwUvBwaUF1YFMHFKb3lZpCR5+7hbUA4UL7XGpL4vsGmaRsIyQg/mbF9CIWqoYqKeIfgjS1lsazM4uNarZg6irsJcLHA@vger.kernel.org
X-Gm-Message-State: APuU4Z9wTwos6tdzzbotUjrycJhrps3egVvHFziaNvvLeY9TuKfgH3QU
	MTqnpyeo1r5Yw6ardvckPxxhxaoliEILUxSxjAb17dWDJcnxf1+WnOfJRs1mOmOHk7gA96476wg
	dFVv+9xECD11G/5Ix+0vrudyKpY0nbTiyMqEcH+xP
X-Gm-Gg: AYBFou3nL3JA51vdSA8aVdV8RCZZTnJs4xCRF0V/LFt9kaB0AXzCQqznhSaDLJYM975
	wj+1rC/V7BQavZMFHiWTjKWcdh6IPS4CexcDzGee1f+aTXxrzD4HijtAAIDHEjXuQBXUidW3Rt7
	fbOq5XoLRhYz655Hli2ibFbe8IHeFoEQjSlhgVKnDhl1eZqOEwY9KJwuSSRybHMe8pa2dxMAWXx
	VEoayKJdp36xFQ9xlrN3ytmntZdythnAm9AgJTgCruh4qyWLFsJkLSTOAPQLmMKTHtikpIXWLst
	s276NPY0IsShF33RU71cpAmdjVl4rQ4aIPwue9ziVeA4pamq9OVoC3RrUFD7Ha8ZEzYXiUSsmeY
	K9dmIxeRP5WEXv7v/ij+XoO77HNQj/1e9mWiaYg==
X-Received: by 2002:a05:622a:230a:b0:535:bb33:6351 with SMTP id
 d75a77b69052e-54cad1cbfffmr12692901cf.1.1793851089675; Wed, 04 Nov 2026
 19:58:09 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <202611050801.67bb4af4-lkp@intel.com>
In-Reply-To: <202611050801.67bb4af4-lkp@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Nov 2026 19:57:57 -0800
X-Gm-Features: AclHuK9ilpld-rB9xe_U790ds1KMqGY3G5aRtH7xf1WpqhhQsTIWBXwTv7iHjtQ
Message-ID: <CAP-5=fVxwRVmaq-kmVVMN9QFmBG56KKVuA0FpP12t45crrGczQ@mail.gmail.com>
Subject: Re: [linus:master] [perf vendor events intel] 3c989481ee: perf-sanity-tests.x86_topdown.topdown_events.fail
To: kernel test robot <yi1.lai@intel.com>, Edward <edward.baker@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	"Taylor, Perry" <perry.taylor@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 5:10=E2=80=AFPM kernel test robot <yi1.lai@intel.com=
> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "perf-sanity-tests.x86_topdown.topdown_events.f=
ail" on:
>
> commit: 3c989481ee3cc22ac5d34e73862a4016af770710 ("perf vendor events int=
el: Update emeraldrapids events from 1.24 to 1.25") https://git.kernel.org/=
cgit/linux/kernel/git/torvalds/linux.git master
>
> [test failed on linux-next/master 7649ba73f9e7e1e04d0b46213e39c79ae09dd55=
c]
>
> in testcase: perf-sanity-tests
> with following parameters:
>
>   perf_compiler: gcc
>   group: group-02
>
>
> config: x86_64-rhel-9.4-bpf
> compiler: gcc-14
> test machine: 256 threads 4 sockets INTEL(R) XEON(R) PLATINUM 8592+ (Emer=
ald Rapids) with 256G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <yi1.lai@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202611050801.67bb4af4-lkp@intel.=
com
>
>
> 2026-10-04 03:23:58 sudo ASAN_OPTIONS=3Dfast_unwind_on_malloc=3D0 /usr/sr=
c/linux-perf-x86_64-rhel-9.4-bpf-3c989481ee3cc22ac5d34e73862a4016af770710/t=
ools/perf/perf test 77 -v
>  77: x86 topdown                                                         =
                                      :
>  77.1: topdown events                                                    =
                                      : Running (4 active)
> ---- start ----
> ...
> event syntax error: 'cpu/mem_trans_retired.load_latency/'
>                      \___ Bad event or PMU ...

The blamed commit added the event:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/tools/perf/pmu-events/arch/x86/emeraldrapids/memory.json?id=3D3c989481ee=
3cc22ac5d34e73862a4016af770710
```
...
+        "BriefDescription": "Counts randomly selected loads when the
latency from first dispatch to completion is greater than any number
of cycles.",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY",
+        "MSRIndex": "0x3F6",
+        "PublicDescription": "Counts randomly selected loads when the
latency from first dispatch to completion is greater than any number
of cycles. Reported latency may be longer than just the memory
latency.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
...
```
MSRIndex 0x3F6 is ldlat:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/jevents.py?h=3Dperf-tools-next#n238
and looking at this in the pmu-events-string.c I see:
```
/* offset=3D3016743 */
"mem_trans_retired.load_latency\000memory\000Counts randomly selected
loads when the latency from first dispatch to completion is greater
than any number of cycles  Supports address when
precise\000event=3D0xcd,period=3D100003,umask=3D1,ldlat=3DNone\000\00000\00=
0\000\000\000Counts
randomly selected loads when the latency from first dispatch to
completion is greater than any number of cycles. Reported latency may
be longer than just the memory latency  Supports address when
precise\000"
```
Notice the `ldlat=3DNone`.
In jevents.py we have:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/jevents.py?h=3Dperf-tools-next#n331
```
...
    msr =3D lookup_msr(jd.get('MSRIndex'))
    msrval =3D jd.get('MSRValue')
...
    if msr:
      event +=3D f',{msr}{msrval}'
...
```
So the condition is only testing the msr and not also the msrval,
which is why `None` is placed in the output code.

This output should be in the parse_events output as the failed to
parse None should be somewhere in there like:
```
$ perf stat -e cycles/period=3DNone/ -a sleep 1
event syntax error: 'cycles/period=3DNone/'
                     \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'cycles'

event syntax error: '..les/period=3DNone/'
                                  \___ expected numeric value
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list
available events
```
Anyway, I think it is sensible not to specify a ldlat value when the
MSRValue isn't given. I'll send a patch to jevents.py adding this.

Thanks,
Ian

> event syntax error: '..atency/'
>                                   \___ expected numeric value ...
> event syntax error: '..atency/'
>                                   \___ expected numeric value ...
> WARNING: events were regrouped to match PMUs evlist after sorting/fixing:=
 '{slots,cpu/topdown-bad-spec/}'
> ---- end(-1) ----
>  77.1: topdown events                                                    =
                                      : FAILED!
>  77.2: topdown sorting                                                   =
                                      : Ok
>  77.3: topdown slots injection                                           =
                                      : Ok
>  77.4: topdown metrics_clear no extra slots                              =
                                      : Ok
>
> =3D=3D=3D Test Summary =3D=3D=3D
> Passed main tests : 0
> Passed subtests   : 3
> Skipped tests     : 0
> Failed tests      : 1
> List of failed tests:
>    77.1: topdown events
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20261105/202611050801.67bb4af4-lk=
p@intel.com
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>
