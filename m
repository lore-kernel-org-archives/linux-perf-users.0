Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793368451;
	b=PPrkFF5sVbvMnGqKmJwg7rKpx4Pfo8qf70HXPO1tc/5YpxUTCOjuXm7v+YtAnCYQalCu
	 ohFPWIjGczh7YPD1i1ji036lim+5sFppORNWWUeaUTKZXBu6yTcV+FjH+mpZuGb89wujD
	 655nESbAt8X4Xubv0ybZfddIhYLo2E5NGjMKA950LTDJqbKl/u1OpQDle+po9VJ5r1r28
	 3dd3bgBmVeQ8rzRc5IbOZtOfjXV2rBBmMJOU4x1Wf0OYxiPwyEaVqQsJP3w5U6pB1i/zJ
	 5Q+V9nA+yIAL7us4RKfNs7TcDBbbrJCFk1zYuoyECMQKdHhej9srd9oflcLMwEymPBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=BAuLNHPNJqqoWJmSv1jiLnRdkmUVQGOL2ovNhcmC/YY=;
	b=frF15W1UzcrjNB0YieKyGCZ/4nhHZtq57uh+7yUkT0sfaJ4NsOt/ZsrN00NS4V1/VFVh
	 81ieKypg+3GiwQVTfy+Jepkba0pMlSwJbnGUEHMTeNoW+xiXhiUqURppyl7C0aD3iG14w
	 ED/xXtvq/DTN0pZQTtGw8pXrxhxRvVVbdMDe4Jm8K0q3n25KfEMC0tt0smKQmkuZCBVsP
	 YddLL/7cncoOm4Ro5B60ul2IJ3tns2962j+KNvGv8EzypkEp9bC7s3wc5zy61rw0677+7
	 ZtQkH3bgHkfuSMKr3pmmZZjmFGJlkziHsPLbFNMYeEpmHHv2YDlvjYUwNS3h3zivkOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b="oo/gDQ1H";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D62606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 13:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23D62606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=oo/gDQ1H
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-677bc4704cbso641954d50.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 06:54:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793368445; cv=none;
        d=google.com; s=arc-20260327;
        b=XfqibRL/tvd6S8iomzILDRdrL8oPE6vhKYO4sJaXpMG/YifHWATxhauzPUmgGdNF3G
         VZpNdILplUYNaK9hp/G/NxpUdveLXbmX44Ode6ltMN5b+E//2ln7yPJ5xCfIgUBh4YZD
         bZKOjIfHvRD/JrsmUKM3azMbnk42HmOd3i7tMZmM1AxrqIlXkH/B6moBcSIWoDvDeSEA
         3zDO1FpauFEwPaIpKLCxbPqtODqcTpheZmeP371GO00ya/LW4pafl1iPzadQCHk9PxC2
         /oHhSRP9sRv9EBsqoUeW9wodHnmgS5Rwrp5iZEdLPIl9VszHAnvREztmBHrqDW/CHmez
         ylCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BAuLNHPNJqqoWJmSv1jiLnRdkmUVQGOL2ovNhcmC/YY=;
        fh=fUs+y8qPYjDxStqke0ZxVX3Zp6zwLJH31VyRRPmyYnI=;
        b=rqzvB9LXmivJbePBoqXpPZNkuXbpLXxUn1XRzH/ms60xjo4o5Ljc0/OwIMVR4cn4Gi
         0iolAY15lQ0PBRPzZmO0lJ2SGqaizWHU/nLexoAWdA0UqwsDj4eNM1+xTvVb/uFOw6BE
         z09scj1xPTit/pMyyo7G3Y66yZnyTAfRqnTxwr8VpvwO5C4Qo8Lkqy1m9Z6m2UjzDi+j
         JT3/NWmA3xhFkJj0HF7cV/Og94eNWPITUUC/JVWGzdFMokJ1aMcFgS6x/o1FG1Vmc4zy
         Dz5v555+x9iBWg4UUBt3dfE3LV6+cxwa08Vd6G0LyA4soYyXwWOlICWMYdPopvg2Q7Xp
         1z9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1793368445; x=1793973245; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BAuLNHPNJqqoWJmSv1jiLnRdkmUVQGOL2ovNhcmC/YY=;
        b=oo/gDQ1HmcwaZyjfpA2G9VFwx996PJQ2JK8EgT+15BB9Yu1b3YwRk98RYORY3hrVq2
         7tTk7woQsPGj3s3kHexvcBU5TjbBuB+Ut6T9Q/8eU4l+rGY6B0Qy1lOnkr8s4dsu2b/A
         aHkWmBZFNMqUm2kmaLZiIM7uS9A4o/zRNzfz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368445; x=1793973245;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BAuLNHPNJqqoWJmSv1jiLnRdkmUVQGOL2ovNhcmC/YY=;
        b=FqfK2UbsA1hvC7Gc590mJbJfUa2y/hkTTJA7z/mEpiEZrpWaEA9olX258ncJo53K6/
         1wFdTXdaWsd67cKYckvsnwMpsFEXeABJ3o7gHrPtM/3eF0wfEfc2BTyMZO6rxFuM/x56
         K3SsUKJzAVqGfJMuWfB0sfx+qVsm57O0tvZfhklc+m0XvHMZAY+VTTniOgZbqOKWts1L
         kogI+5qJo28loFGVSgrJbzRBe5d/EO6m91mE6sR00diDu9rY6PXL9ia2Gb97mnaWZFCH
         OyYtZjKe9wl2XTVIqjSxbvvZPURwDNBLJjmS/ZgeATLT+tfboBkfASLMWCgieskk0kOP
         bk4Q==
X-Forwarded-Encrypted: i=1; AKwUvBw0PEwoPTUCBmnF8eReLCRt90I9a3yzei3Usfc/m3D7YVgtIcFyaKB68jl7ZV9Z4A3uJlaqscIXnZ0chbC9gfbB@vger.kernel.org
X-Gm-Message-State: AFq9FYKw1v0nmK9fWzJ0NM80dwXgzTDGoGc90NRKs5TqZMKm1AKjyIPO
	xwXfk1tAqEnTZKEEtUiNfW+qWMAUuva6Hg/XDHud94TvldsHhFGMFg06LxA64rop8in2qYO0hte
	0MnhtsTEtcLYg/G74qxZeuD5VK+d2+eO3iN/E2mBxoA==
X-Gm-Gg: AYBFou1rVp/0sXMRVXLppb5TYDS1KpuN/VGosjGTY+1ma0YQNKeQTvcdj7VZAiinA8a
	m4kaGOeI8HJHcU/umq7BMUwa/5gvBUd5QMGuRTDBd/ax3t9kw6YU7wRDDAtLrZA4GP8pfc2rdsk
	LSVG41rp9dnkqy9J0jQb8OafRAEBx5Knx3fzaKYsdSmeAi1GPjQg8UuHw3t9c10X+iL8AuuUv+V
	xwKecgj64ckaOt4tE+2tNc03EKv5gIbeJlljOlSLmSrAuOwVlf4A9NquvleWKI7iQKY5vlijcXD
	+zl3ezyQq5PjHwSiDCUFTXJwMmvDiT0WEMA8JqV6w+57i+AvZWj+L+Oa4uB8TFiS5NEbOzWSFeb
	+WcZoNsxt5sBMLD2OlYMcikAieVQcvd96+8pIB/rCeIxSuayka75mAA3YEvHAzftm54K9+A==
X-Received: by 2002:a05:690e:803:10b0:679:94b3:a257 with SMTP id
 956f58d0204a3-67ba5072b56mr832427d50.115.1793368444841; Fri, 30 Oct 2026
 06:54:04 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <20261027231513.816148-1-irogers@google.com>
 <20261027231513.816148-16-irogers@google.com>
In-Reply-To: <20261027231513.816148-16-irogers@google.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 30 Oct 2026 06:53:49 -0700
X-Gm-Features: AclHuK9qEUQ8arGpnCaqKbufakBcpdC2RW03pQw1oOPGVk-0ZrZp_NmRX624f18
Message-ID: <CA+w=M=TDksQKaU4R+og8eTS=17NWSsACaoBnpv3rM6tWiZ37Fg@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] perf symbol: Add memory shrinking for symbols,
 DSOs, and machines
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 27, 2026 at 4:15 PM Ian Rogers <irogers@google.com> wrote:
> + if (was_shrunk) {
> + if (ret > 0) {
> + symbols__merge_retained(dso__symbols(dso), retained, retained_cnt);
> + } else {
> + dso__set_adjust_symbols(dso, saved_adjust_symbols);
> + symbols__restore_retained(dso__symbols(dso), retained,
> + retained_cnt, retained_allocated);
> + if (retained_cnt > 0)
> + ret = retained_cnt;
> + }
> + dso__set_symbols_shrunk(dso, false);
> + dso__set_loaded(dso);

Could the failed-reload path leave the DSO in a state where a later
lookup can retry, rather than clearing symbols_shrunk and marking it
loaded?

If the file is gone or no longer matches when the reload runs, this
restores only the retained symbols and still marks the DSO loaded and
not shrunk. The evicted symbols never come back and nothing retries.
For a DSO without a build-id whose file was replaced, the reload would
also merge the new file's symbols with the old retained ones.

Could the reload also build a local struct symbols and swap it in
under the write lock, instead of exposing the table while it is being
rebuilt?

dso__load() currently detaches the retained symbols for the whole
reload and merges them back at the end. map__find_symbol() waits for
the dso lock, but a direct dso__find_symbol() from another thread can
miss the retained symbols or get the fresh copy meanwhile. In a test
with one lookup thread and one shrink plus map__load() thread, 115,691
lookups missed a retained symbol, and most of the 13.2M lookups
returned the fresh copy instead of the retained object. That breaks
the pointer identity annotations rely on. Swapping a completed table
under the write lock would close that window.

Smaller things:

- symbols__merge_retained() is O(R^2) in retained symbols because of
the already_retained scan. Both arrays are sorted, so a linear merge
works.

- symbols__fixup_duplicate() no longer returns early for
allow_aliases, and dso__load() now runs a second dedupe after PLT
synthesis on every load, not only after a shrink.

- choose_best_symbol() now prefers refcount > 1, so which alias wins
depends on references other threads hold at that moment.

- If shrink removes a newly populated cache entry, dso_cache_io()
returns -EAGAIN. cached_io() does not retry, so this transient race
becomes a hard DSO read failure.

Thanks,
Alireza
