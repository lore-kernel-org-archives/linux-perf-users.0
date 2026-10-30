Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793365951;
	b=JLX9+NbcDtfX5nZmIagQP6wv7I8sg1Ipnrd3mF3S1s9fGaJTITSplWSUf8wgBEGgJJKR
	 yjjach0B+DVD3pfKuzjhxFcKFOBH+62bOHdgvgPQqrRkVXF/9IMo4IgJd75qAZ2HS50p5
	 bYoIUSm8X63QAN97nIP2E0lvFDz/dAQVWRRMOFhi9KYWU/75R2ZX/wBLhq8dQGl+KiRil
	 CPf1v3JngrfvMRrqvDSkWqtXHlzwBQbTnAxxo/uPzlAcA/ox7rnSiYH9lfyUrz9IwOF/o
	 wPDA+E7ZiI8PM2w2B+7f0GllKVMgW6+s42JdV31Q0/Vxyz7N4Uh3n/WIXDLVHdO1lag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=dDBHKImO6A2eY0c1X6s+PbB3F+7X5/fjHZPXEe85mFc=;
	b=u6te1EwYMbILiXLRr6h87asMgRkxFk1L0aphXurUXTPCy/RdjI/0NO9nOTYt4PFlweto
	 YFGl/MKhfi7hCXofTqhA/FrtYtBwMYRxRJy8vdFRpPAvff1pi8LmUMubiThLlOHRTwEAw
	 fmxWr2VSFpGntM9UpvZ+MVXv160Xq2u9ENl3s/x5r8YwHmZbHpUW+ISrZNex5FMswJo4W
	 GRG5OcLlMlItEghr39thucMSii9hKpJyXHoRTzI0vL0Dju0zLt2FGZX680qcv3xN+9pJE
	 Zr1gmA9HkKZRwEatfBOUmF/gPsBt/RV3zSHoWeTfJgMBZL6lSaJRQvo5KJr7OvluOGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=D3yKQ2Jd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D1E606A31F
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 13:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44D1E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=D3yKQ2Jd
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6798eb0d13fso562643d50.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 06:12:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793365950; cv=none;
        d=google.com; s=arc-20260327;
        b=ddBgnIX4ickaQY3mHgnPuv0H3hg4XUocBwbIyABTln/ldfmGqE5/o2W3JsTMZmS1bu
         UlYEIYpovKc76kcVN1rivtkaqMvqOvtP7Hbgaf6yPABvzDQtHvNl7leNv56/tTcbjNQ3
         UVvJRkrmgNXyq0C7hH3SrVoF/372b78sg2G9BMyyMsgo7FoWaMgywtjqXcR1zryMcjv+
         tAgqI0hwxqgyRngPWpPtNZ9BD44vlAccrCImFRudiT5HYfnIk8y9ABLr+MFc24dSNHtP
         rR9iuCUnrSHU4RofOnSGahDT3zIoo4Zhk2NtoI+MVJIdUMtFt4H3ui6IqUXvkkdDgste
         5KPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dDBHKImO6A2eY0c1X6s+PbB3F+7X5/fjHZPXEe85mFc=;
        fh=uFGqeQqXg9ZJsPic0/ygO81wv84ABSq40lR14Bg6Cq4=;
        b=ONRe8w2MExng7RNHmPwta7wPQXi45AOofpYEYfxuL4wzhEK8carvu73YeUr0jp0N4p
         xpd42Bt8JrGD14St8YWOAUY80R2sjTZ1eZGvpyJHzwX6UJmEDHZYc60d1kkD6040V0er
         WByvW5SEdHv0gsqTQkYhUS1sCTaw8DqgX9nRDgv4gwBVOpWeNXlOok2GanWUAStUuQcL
         bHQp5G1/eHs3bjR52spQLIaMjSwPxiKnM8nXpnz2yFIg3Rk9gcVJVbBaKSipvyLgHsEq
         e/Ya6tJm2kns8odq87HwG7ZrWlPT7DNni4wSOGogmEOpLBBhO5CQyuHVP51eSeZ00yc3
         0O3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1793365950; x=1793970750; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dDBHKImO6A2eY0c1X6s+PbB3F+7X5/fjHZPXEe85mFc=;
        b=D3yKQ2JdWepoaILQnUijgya8UQM//JiglGXTQB2J6NrWBmvwu1wopzjWxV070FzF5M
         QcLQaiBhVgJ35vAuvLekKi+yUE62PPqC4LsOqFx9MW33G2SF6KL+iZeE+iw/Rtlf1gVo
         +g7p3NexqyD7Z3WcyY0kM1ugLrGIn1Z+U3qUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793365950; x=1793970750;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dDBHKImO6A2eY0c1X6s+PbB3F+7X5/fjHZPXEe85mFc=;
        b=tRp0Ib/whWWJVAbclIHstZGs8Ekfi+qRhyWritVeoUe66NZ3awijOxRxSwpKM0VtRN
         DNuT2LYswizSIpUTNeh8EP8XSTi4bViQIbcKrflkhVIMw9isKWBEmZjeHm4YoSCxqW5m
         F4JfbWqFCxWYuWMuHI93S/0+8AgSBhtT5FbQryQMR84Q5zDz5JFaWNQFuMYAjJ+QN7Gh
         tXFyTFnSU2yBHUfuf7Q5nXkM+AJivxbLRUe0OdH3yPrR8hVt+mbmjg8GYpyJ2fS3Ejn9
         P7A9Ddu5cpwp0Zhlk55uc5GD2kPekA7eqr4dcNKwq2ef1++MvejApsqRSuu3VMkPkWK7
         Qu/g==
X-Forwarded-Encrypted: i=1; AKwUvBzHneCLcXq7Y6kxN8rlaQVbDt1ggVGVsx2lcd/9MKlbXs8jgpFKbsaWREMfITv5lOryFF4FDTkagmK3Yjtvwchl@vger.kernel.org
X-Gm-Message-State: AFq9FYLUBIkttkRpA2lnqwHPRZdU0B1kSw3C+9xFzNqDMLDZetNAIw+o
	NYxjCNENc2f3fc1n1HuP/0e9HuJEv/11YvvFqNljqq6mPtZCtR4hoGUjiu2gscO+fGqVhVUdsSW
	POx0OqszrUY7H+nUXDDGmzYL5Ef1mP7mRCsclgkjTIw==
X-Gm-Gg: AYBFou1cw3ljp3GFXKzQCInRclMlJtjOsPfJRxU9ZzeqAWOLv93AUmpE6e+2OlduOoE
	jqlW1/HQvxywc+jF0Az6ZpvDBlaz2RsVy5474cyQtbJpbgTNhw3Xpj2tlx2ljHkyvOtS9LweEs3
	m7msmYETln14okfkXZ7PaM6a8EfzXN1sg0C4hOy0yHPv/QAFN1NO0WDl81yLkOPm8fhBRDDv840
	Is3wqBumSl/rKeKeqCCly6OowWqnSbfXBoroSo7TIcGdEwKTj93peuIE0aWLtA6iGq9dvhEI+j9
	s9hdJWL/0RqDFhzotyGHNv2CK4/RnY4irnazdBUKehJVmPSvScoEioXyp8zi0qRYvImxKiCHCTv
	ate4+rfO9QwiU1T6/wK+ffmDASyFHnoTm7HZzB4pc6RwIamPGdJq5BRZKC1Xuev6Xoxm4Fg==
X-Received: by 2002:a05:690e:1699:b0:67a:6b2b:b864 with SMTP id
 956f58d0204a3-67ba4ee9dedmr1201735d50.45.1793365949593; Fri, 30 Oct 2026
 06:12:29 -0700 (PDT)
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
 <20261027231513.816148-8-irogers@google.com>
In-Reply-To: <20261027231513.816148-8-irogers@google.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 30 Oct 2026 06:12:13 -0700
X-Gm-Features: AclHuK8xzB6Md5YiYDKg7cBeqIUYy-GW213xYmIva0VuA5491eZtPnV7iOerbJU
Message-ID: <CA+w=M=Sx_X=NsvvNEtwgjBtHZg=fnPiaBPyqopHXze3NRe7mLg@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] perf symbol: Switch backing storage from rbtree
 to struct symbols array
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 27, 2026 at 4:15 PM Ian Rogers <irogers@google.com> wrote:
> + if (symbols->sorted && symbols->cnt > 0 &&
> + !symbol__less_or_equal(symbols->symbols[symbols->cnt - 1], sym))
> + symbols->sorted = false;

Just want to call out that in here, every out-of-order insert clears
sorted, and the next lookup qsort()s the whole array.
This is fixed in 9/18 I think but moving the sorted insert into
this patch make it more clean.

Some behaviour notes:

- Symbols with the same start are now ordered by end instead of by
insertion order. That can change which alias
symbols__fixup_duplicate() keeps.

- The order of full ties now depends on qsort() being stable.
Patch 09/18 replaces it with a stable sort, but still falls
back to qsort() if the merge buffer can't be allocated.

- On libc.so.6 I see 62 differing @plt-name lines compared with the
previous patch, for example __GI_memcpy@plt, although both sides
still have 55 @plt symbols. My guess is that this comes from
get_ifunc_name(): for an unnamed R_X86_64_IRELATIVE relocation it
resolves the addend with dso__find_symbol_nocache(), and libc has
several IFUNC names or aliases at the same address. The old rbtree
and the new array do not necessarily return the same alias there,
because same-start symbols are now ordered by end and full ties go
through qsort(). The PLT address and count stay the same, but the
displayed name changes. Was that intended?

Thanks,
Alireza
