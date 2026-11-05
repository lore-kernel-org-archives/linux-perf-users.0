Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793852558;
	b=iTjnrBa087VCxf2Ha/hD4HfI7i96dtqOBRxhyGjcgT//MWToL8U/5UxZ9OW42Z+kZVuO
	 al6hJUI88h6yfHUlWF3JLm3FhJyM8EAOQi41nYucP+ZVnHKafSMcyNsOTtLgYKEA8NNF5
	 knb7WW0mwvOUu6xDmqjc1A0Coau+IodMqB4+fIy9bC5IUrE2Hnrfws3ScrDwopCzk2WRe
	 eKTOkb+GA7zAYKY4tdrrWFAu/YAfW5M1ZHdevfx4zcJ3clz6SzMRf9qF/vX6ZObSqGSSI
	 Ca8PhTnFcsCDburn2l0GSvHsuvqwxjcYsUtKHywpAlZgCtqybyGi/+khO1hs8nWHj1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rU/4KhKmMNOMVfPO4Ct4SOXNAKasoIJ7Z9nUaXuCxpE=;
	b=w+HjQfSQ1xQS7yxlFVTSM3gimzOhd5Brg9hLzrRkoVxxxq9GIz1CuOJhH/NirxQqzG7n
	 HAhzJHnn6Ngj2OKxtAP4lHPLzvofgU5a42oNGWdJQyN0cXrIwbt5idf30Kkg1VPyFB5ZN
	 NfnJXNjEex6+8/64mQDEnKPxX7FLRVQFARyhkaInfYiiC4hrM0trjxBCBxEaXLc+WxGcg
	 6+FwQdJDIwSmOrtjuk56wcJIL5ZTrpJYzcKvzX22DjU/bOoGmw+YoXjGJR2U0nwwrZ2Qi
	 RIXzfAbXAc1pzrx3F1YC8y8CYxbOWgjD1UtmkvTjIXuMOSp5RRn68adIqbu4+N11HEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h9p4QW59;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC662606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 04:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC662606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h9p4QW59
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-533202fe429so166831cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 20:22:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793852557; cv=none;
        d=google.com; s=arc-20260327;
        b=nMheWy6yQQKB8t6z+gTwzPyEiFv98osIyTEDYjU0LGp7ZmggmDCw4t68PQympZhoLr
         v8hn4quM3/E7ElKax4xOUmSYjA5maczkyx3wEPImHFsSh2W5ymI09k2g02lYjgBQdI21
         VHo4PPBbz+sDKoqYYYFbgtdfamDXPxCaPCsWI4NQUdmsnq/gK6Hg9QiTl4S4OL9q/5tn
         pzoG5D4g7aHdBVGwLN6HD00CmiGFZzOaBgees2iPK4wKPPPG3mZ/0ACptGtVsys8wdji
         KNiO2kV5Fp8sGsVc2KHcBka+TziZnaimXxap1qUWf4Ec4fqe7yQWDc5V6UcmjptbPqJh
         V3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rU/4KhKmMNOMVfPO4Ct4SOXNAKasoIJ7Z9nUaXuCxpE=;
        fh=P3j53US2IHJMgujixiXqeCiTVeIpYHnwThVZcUUVhNc=;
        b=nInw4uX9t2CuDz4iOtg2LxZS90hqq6aynrFi3xH4OXHiTA8JGupMVdGrv+MMM+wx6V
         Cp5aISmQ8ocFfoAQJ14zhmKX0JqiTbEFiN79rl+FszkFKuxOHV+LVXHYhCPdNQBMY1Lp
         T8vuJUdjAA9or2VKNT2BN3yXmluM9hpRlYfyGweUTlRg7SxA8idw9aQfCN55EQDxkTTq
         e98jqR/zbUax/axpDsHVqIad691VLZoH8RMWENFO2xMkcgpG0rA2sYh1QqFLKPJyIdgx
         OfJq0ByKxz/h0SrhxnpStfK6nkMWpmt4++0brMDPt6VEajv8QDz1c6osHR1AHQkVLyvX
         itxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793852557; x=1794457357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rU/4KhKmMNOMVfPO4Ct4SOXNAKasoIJ7Z9nUaXuCxpE=;
        b=h9p4QW59kcNpNEWeWTZIPjYs++e6daaEyjCpJT6LCvBeW43x9D0etR1eAsEfV01csn
         PNllthAghliX1dy0d6/VkDm4pBGb2FNCS8VDpwNEx6TUiGKvYiDviCd7tw0xQrDxOXVo
         Jc+Kv/owAn1exLRGnpqRWiXtmOFgSDE9SWjUzHnWOXlIGxEomglp5CmrJXQ+i9EuB3MR
         MUi96B9pXIqylnHbXK4319xES9t4pQhw+v4Bmn2tBBLBMoWyEyktIxUrKqlEs59b8z5t
         N+fYrgQr0RG4m8n0l7w2tigG8rgUsX7vEOrrz1LuNFR8+dFH7i51xO+3fhtcZOzNGgD8
         dd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793852557; x=1794457357;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rU/4KhKmMNOMVfPO4Ct4SOXNAKasoIJ7Z9nUaXuCxpE=;
        b=tpfzSOcgpLcTbTW89VHi7fJigD90bgP8jkAClzOG8UunNifRV/YMieWaR7dWPZ7sZc
         1OZn8LRhMshYwhWhpS1rgaICyVHrqoGHHyvOk0aQpFPFJzqxM3PXONpXUuHPePdhHxYe
         DqhClrlbOYdqrkbYRTPvUIyFoJQryjMkoneljzt0nBDXN1RbtkHNzg7DlxodYObC9t/E
         tUGtJqxmJY4kLk+UmGO7Pr4mBawBkcaGUxOytvuj+UTL6FwbaxIKDb2iHY9n1fTd4ySo
         7sQ2O0AvQbN2j0XucShJbtkS5s88NA/3zXH4G0oBbePOeLsUd76BZhUkuPtjBUf98xut
         +gkw==
X-Forwarded-Encrypted: i=1; AKwUvBwFisQNoOmvHF6Blry6Ach1XvJeLXuGDzjk8czecW3XhKnLJwJykjwmv2WbkxJCTrm3jfce11bZjFlcd/sAqmhj@vger.kernel.org
X-Gm-Message-State: APuU4Z/9W/tz1x0TXzI3ais6IPwYAve3YZTUi4IoeSqKGM4GdBGPob0k
	J9TVhF8RE1jXhY3i5OfBvBw+vKDFAnEtnkQt5D4wozBLt6HNcjv2qodi5rg5+yf54K6+/mjy6wr
	eUS5VV5Z4eh7OtyMEqmgEZ9HmYtnrywx8StA+pB2O
X-Gm-Gg: AYBFou1si1LcS7mPP57YDi/jK2V5Xcofy5qSLx0j6UQDKEMbVqIMgy/Ga4ylh6zqnUc
	68HiDbf49Yd9XtvwiOnPnqaKkzSN10jVfdH6Iza6GbYPUAfwh6YQ9vVjZsbWm6z3yr1uP2dyJx6
	9wqCQKnnT3AhEwkKVVBYag9eJ/yGQ2J5rrpbuRZMhW3k4XGvZsNhVySqbBPtGuAOz2QKgvOkULs
	PYR3m46/Obr+TZCbwQX+ZZsS/LCVe0Km9zqKLHVtGOBp8AG9UQqFSAyIyFwxcqYtOMGOErSpp8s
	lo81bjWfcWDxT5KIiky9NtthaQIJrmw4jElyVNmhLPuIwO1sKn9ZRVMgFOEPQWEZMRY4hmPMMvD
	pt2gS/GMMH+az0QtNrWKWo5UpnOawCsWjOVydyQ==
X-Received: by 2002:a05:622a:90a:b0:536:97c0:dcd0 with SMTP id
 d75a77b69052e-54cb0bbd967mr11728581cf.4.1793852556274; Wed, 04 Nov 2026
 20:22:36 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <202611050912.2cdf1ff5-lkp@intel.com>
In-Reply-To: <202611050912.2cdf1ff5-lkp@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Nov 2026 20:22:24 -0800
X-Gm-Features: AclHuK-N2V612YytHJhEuD7FLzc60lFV8mbdHb9a1ldBGi0Aa4UQbVv_1U8wafw
Message-ID: <CAP-5=fUk4Q3PxNiqwHtyM6XTt9LGZaTe9p7o9k2gL7f2LBRBHw@mail.gmail.com>
Subject: Re: [linus:master] [perf vendor events intel] 31efbec216: perf-stat-tests.UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU.fail
To: kernel test robot <yi1.lai@intel.com>, "Taylor, Perry" <perry.taylor@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Edward <edward.baker@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 5:47=E2=80=AFPM kernel test robot <yi1.lai@intel.com=
> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "perf-stat-tests.UNC_IIO_NUM_TGT_MATCHED_REQ_OF=
_CPU.fail" on:
>
> commit: 31efbec2161d2d31b020b086958e41f35f070a38 ("perf vendor events int=
el: Update sapphirerapids events from 1.39 to 1.40") https://git.kernel.org=
/cgit/linux/kernel/git/torvalds/linux.git master
>
> [test failed on linux-next/master 7649ba73f9e7e1e04d0b46213e39c79ae09dd55=
c]
>
> in testcase: perf-stat-tests
> with following parameters:
>
>
> config: x86_64-rhel-9.4-bpf
> compiler: gcc-14
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (S=
apphire Rapids) with 256G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <yi1.lai@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202611050912.2cdf1ff5-lkp@intel.=
com
>
>
> EventName: UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU
> 2026-10-05 17:15:24 perf stat -e UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU -a sl=
eep 0.1
> event syntax error: 'UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU'
>                      \___ Bad event name
>
> Unable to find event on a PMU of 'UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU'

Ok, this is an ugly issue. When we fixed the issue so that umasks of 0
weren't dropped, we added new umasks:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it?id=3D31efbec2161d2d31b020b086958e41f35f070a38
```
...
@@ -1923,6 +1974,7 @@
         "PerPkg": "1",
         "PortMask": "0x0000",
         "PublicDescription": "UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU",
+        "UMask": "0x7000000",
...
```
The umask calculation is odd:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py#L361
```
        # Combine the umask with the umask_ext. We don't know the
        # width of the umask as we concatenate the strings, removing
        # "0x"
        if umask_ext:
            self.umask =3D umask_ext + self.umask[2:] if self.umask else
umask_ext + "00"
```
For Sapphire Rapids the UMaskExt is:
https://github.com/intel/perfmon/blob/main/SPR/events/sapphirerapids_uncore=
_experimental.json#L17422
```
...
    {
      "Unit": "IIO",
      "EventCode": "0x8f",
      "UMask": "0x00",
      "PortMask": "0x0000",
      "FCMask": "0x00",
      "UMaskExt": "0x00070000",
      "EventName": "UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU",
      "BriefDescription": "ITC address map 1",
      "PublicDescription": "UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU",
      "Counter": "0,1,2,3",
      "ELLC": "0",
      "Filter": "na",
      "ExtSel": "0",
      "Deprecated": "0",
      "FILTER_VALUE": "0",
      "CounterType": "PGMABLE"
    },
...
```
So that's hex 7 followed by 4 zeros. In the generated perf json it is
hex 7 followed by 6 zeros as we concatenated the UMask's 00 to the
front.

> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>                                   \___ value too big for format (umask), =
maximum is 255

This error indicates that the UMask for the IIO PMU only expects
values from 0 to 255.

So something is wrong in how we interpret the UMask and UMaskExt for
Sapphire Rapids' IIO. Could someone from Intel take a look? Is the
problem in the original perfmon event json, is there a different way
to encode the UMaskExt for the IIO on SPR or is the IIO PMU on SPR
constraining the umask too much?

Thanks,
Ian


> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>                                   \___ value too big for format (umask), =
maximum is 255
>
> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>                                   \___ value too big for format (umask), =
maximum is 255
>
> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>                                   \___ value too big for format (umask), =
maximum is 255
>
> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>                                   \___ value too big for format (umask), =
maximum is 255
>
> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>                                   \___ value too big for format (umask), =
maximum is 255
>
> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>                                   \___ value too big for format (umask), =
maximum is 255
>
> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>                                   \___ value too big for format (umask), =
maximum is 255
>
> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>                                   \___ value too big for format (umask), =
maximum is 255
>
> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>                                   \___ value too big for format (umask), =
maximum is 255
> Run 'perf list' for a list of valid events
>
>  Usage: perf stat [<options>] [<command>]
>
>     -e, --event <event>   event selector. use 'perf list' to list availab=
le events
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20261105/202611050912.2cdf1ff5-lk=
p@intel.com
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>
