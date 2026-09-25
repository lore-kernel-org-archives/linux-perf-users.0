Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842674AA03F
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366131; cv=pass; b=WDDZ8aoNiEmb0r9X52+dmwqAOwU9jZAdlgG8e4Sy5WE44f3v4z5rB6qnCjF2nGEqepq/s6rDqQRTWvSi5tGBkxHHcoD98SwbcecK9cV04qiqKcTGxdi8paz0QrEGn7k6uiP7Pcr5hQB7FNrw6RNHvQcQO4SJy7JqPHF0zjnWaiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366131; c=relaxed/simple;
	bh=y3d480aQ4neFXYQOEaCvASlHXtKnpBE1ubNE+6f7raw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYmRTXNWR3B8oBpfYsAMULTtBGTwYBpQF3IBHWIqQR8Csmbw29oGEOKgcB5Jjx6yJXQqeBvJUKd3rsKrKVLmyr5QKSu8v6uHjFDVPj7FjKPGGRgYPBMFRBu5DmuxGRU4mmPp3JoZNgTUjq1aJaduh6BZbp5H97CRQcVy6WISopA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=wBeTCMps; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="wBeTCMps"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab201ecso1293762d50.2
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 12:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790366128; cv=none;
        d=google.com; s=arc-20260327;
        b=GKgVcEThlA/g4igfECKKTuwVMvNdAd6xqUH2kCqIillbkIDijmdISwPcs8+QrHAqJC
         4NubzzMGVFXcQY4Xc74Yvn+qrfjpQo+JHjOsARQHGv0bjMzTTLG1LnWt/Gs8juF1YuIm
         R3CazT1xXhjHvleqj9YydebUETIg3g3PuCb9VSh6c3rjspp2HhV16gSwObpDNUGpZ5+r
         nySGpRBGBJFIlrt6IsVD3FO5K/sJiRaODrAXD88lgOR2mA06RnPCV/jwpV0dL36Go5JY
         /uEq0tTyuGYezBfAj7Mt0P/INuSF1IoLFYfg13giM/wclUvsHBv0eSl+4QvJ3GNsXV5S
         HOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=M/kLmD3ssejf7itbaiJfm/99tp9oxE9QonIXci/xOzo=;
        fh=Y8K8iaPlzfXH0GbmXSkuCh/kUXsxqR3JThtIlg6r2zI=;
        b=SR9ioFmLOyGisAm3nYtPRNNUl7rfQirZup/NQrmtlbjxqlN3V44HZJQcYbmx0doRhv
         xhwI4q6hYsxjhqiUjCrDp8NWLq7nIqCG9j0gUJdV+BpTgwrJ5ps+Wj6NitlVaMa2X3Us
         3TTiN6L9FJjzzlIFz12x7GkBmOkt2UT9cphpnSRKoPe01bK2ZoRtuE713TXR2xKUG//s
         AJuIw/yKxuKXfpK/AJdAeiOU1kplKIYeHzKSOdCIoPEwogNxdIMcz4Tpt8ixwl+9Di2Y
         lkLtuhMq0X1x6DnYrT5TqRNwgyu8fB+YbVGduFgGk0CiWPmvQskmRazYqKPGJiTsps2+
         l2+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1790366128; x=1790970928; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/kLmD3ssejf7itbaiJfm/99tp9oxE9QonIXci/xOzo=;
        b=wBeTCMps1t6bOOsVZiXLq+I+rCRB2V+jvSit1DyZoLyG0oHUhct2R7qWUKmfzvrsnS
         lIvCSJ60sKjUz4WsRDjOtgoMB02nIZg2DyzgRh//hzlT2GzZ3zN9ZotrAMjfh7FGmQhJ
         JXxFQowJ9rG9dNpfXG1zFPLpRCIeAZPex+uOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790366128; x=1790970928;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M/kLmD3ssejf7itbaiJfm/99tp9oxE9QonIXci/xOzo=;
        b=Q6l80uysiAJL6hkm6CUcwzsPmOm9ZiWUiMjPd7pmAYJ3E9Uxe5/anDVul/FyuvzrIF
         IjGWU/3m0hZRdei8r9Xj30Ad9PWjROW72YQvzH264Lg33Ng+Evjkq0sPaXjynnuYYNOA
         tY/MNN9Ks87BTZjvWdkvP0LS4bdmUxh35GRqt1vgGPIOAFun05hLhdc+vGZKEYvk0mZA
         ANnEkmLFzRzyzgFg7dA7CGslKgQyxA5nstCNLlTXnIuAeQE0ynX4s6ofPLwdYKP8aHWv
         AsjrzsGuR/CY16SXn0mH+sCDi1sRJNgU6SkEYlVrKyClkifa5tQ+ttJnzBuFjwg7vvmy
         TPfA==
X-Forwarded-Encrypted: i=1; AKwUvBwHyFiCXuhaYgcJbSkyDY2wf7p+hcA9EX3iW6jdTiVqQvp81BMgClSkmapSkajBq38xe3V2yUUxddxd6Ly+Mi8w@vger.kernel.org
X-Gm-Message-State: AFuF++nVDYgQqIVw7x218kIMx4fWDk6tTJGrTM/2mffcW1xxjNMXQ9fm
	trHjDOySnIK1muxL/E4VVlVqFBDnKMr1qXY/c/93GairRuhhejG56xCCofyFAscgw+rNnfqM9PK
	k6fCDOMsWklPe/0bdmyzkn0f/tTADhsj2lstrJB9fM25ZibBEEcUoKkQZsw==
X-Gm-Gg: AYBFou3m+6wjcWGW+V80Wf62ebxJQg9GzyXy0GcP+hvqBdZ7lhE7rYKkXmWMl7iwNXB
	EPjttnOkochYjPMfSaVJNXtqNAxh30ifzP/lKoq3Rno8/9qPNUcxbYyiujNpCLNKX3C38bfqBHc
	DcBlCxgyh/hQTvAfctRBl/uO7dBiF52M9p/hDH9hr6SyVM+OuJm5utqIkZ2zQUkGsNkvl6J9bZB
	Q3BmWOUl53y9q1ZuHGLEEs61LbI37S/vMN2p4CE4mnq+utYwgNtiuQRVjP7P13Kcy/hc4MpSxvt
	h91n6NRmakSVHovX6Oaj5NyrbiVZTDanvPYxqBXsgPWFtqjUbm5u/DZ0/kKPuwzaw7gCZZARlfD
	zHhosxCbtBYU=
X-Received: by 2002:a05:690e:190d:b0:674:eef:ff94 with SMTP id
 956f58d0204a3-6740ef00198mr1221668d50.94.1790366128017; Fri, 25 Sep 2026
 12:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925-perf-symbol-memory-send-v3-0-3e4e234c363b@uber.com>
 <20260925-perf-symbol-memory-send-v3-3-3e4e234c363b@uber.com> <CAP-5=fUumhE1-DT3a-EBYQADy6Az=nViGmz==n1ocqXiXAEQjg@mail.gmail.com>
In-Reply-To: <CAP-5=fUumhE1-DT3a-EBYQADy6Az=nViGmz==n1ocqXiXAEQjg@mail.gmail.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 25 Sep 2026 12:55:12 -0700
X-Gm-Features: AclHuK-_YU3Ru0K4GbKsaTj_Yit9QoL61jEi7xwvNXY-JzFdQZ5vCR4eLAKyjWI
Message-ID: <CA+w=M=RJYSCuk1SoU+OR53Odf6OyKMsjDMUAtaxSmD_4Zyq7oQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] perf symbols: Factor out duplicate symbol selection
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > -int arch__choose_best_symbol(struct symbol *syma, struct symbol *symb);
> > +int arch__choose_best_symbol(const struct symbol_candidate *a,
> > +                            const struct symbol_candidate *b);
>
> Given you can change this function definition and only change 1 C
> file, is there any reason not to make the function static in symbol.c
> and move the struct symbol_candidate definition also to symbol.c?
>

Thanks for the review. Patch 5 calls symbol__choose_best() from
symbol-elf.c: the lazy index resolves same-address duplicates from its
index entries, not from struct symbols, and uses the same policy as
the eager loader. That's why patch 3 makes it non-static.

struct symbol_candidate has to stay in symbol.h as well, because
arch__choose_best_symbol() takes it and powerpc overrides that weak
function in arch/powerpc/util/sym-handling.c.

I can say this in the patch 3 commit message in v4.

Thanks,
Alireza
