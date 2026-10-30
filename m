Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793364730;
	b=e7ojfbl4gmv5hASe/EgodCP5BfWR5U0PPkkM33SFnMGBBmpQB/6wu/J804NpmkCnKuH7
	 lcy6pwD7Ia5OIx7apKV+E8w4YA0hS3Q5cEGMwBMEVbk5CFBfEHvVYEyrVGr/fr4hLuqhC
	 ttYrr6D//RlWSX+JeqGkzPeQ06ZVPncTgEddhRK4lriL1xrHGC70Lt0eGsLX2mAyF/PjE
	 EFL7bqYhIkd6NTQ5pcrHIysMf3hpKPc3LKj+S0oua3xD4fqVtVzsOzmmfsz98fk6DZpBY
	 vb8tJzkBBzIAZ18nT/NGKszjAc3NDV09MoRALJhbf/nzcT9aZOHGX4P/a2Gmu8VPqOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=SV+UOXWZyic3g4Zz1/RbKyZgaKJw7q21Zg/+CpfqSlc=;
	b=WbNWtqX3wZ+KbkD5VEyaNebQNCIX8SMkCoYC21kUm/N4mJbTVlu+mTwZw5riH3RvSkxj
	 hE2bBul6KGmwR7IwoQyKLNyxc1eZycz0ImMWHSQOKKCpF57hAEktfe1NEtYFedokxngCX
	 didcYZ2OvdHy8QkPZy9npRJ3Tc7sBfMDoRw6w+9fMW3d4n25Zfq0RoiCZm5B6ZcfP73Tx
	 JB2TCYUQaUNcrHotyWjqjlw87S0x9klYlLJhItYoS6RR1QVBG1KFKI0/w4jD8uK82ZD4y
	 1KG4Q30xTs0LUpOmfEZVslp6loUKwV3/wsyabiIaBpXOlm3Ugw/zSZV3pGD4Pd1gXyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=7wfJXyr6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A32F606A326
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 12:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A32F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=7wfJXyr6
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67a000ac7efso531802d50.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 05:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793364729; cv=none;
        d=google.com; s=arc-20260327;
        b=j9OdAJz3eTSbcSwWszGZ+IUi8Y2Gdb9mCpKizrOlsZqLeMAFHrH4hc0Ttu0yuVh6pc
         CdCmQWVwSQRKETmPOa/qDkOFEbdLx/rg8cuX6XeF7cjDIyKhWCzShENaywrKWquUr2fL
         8tKs6w6f2xT1mmtKBy6DTsEoCPD4HLdfi9khrR8oCefm7JHRFwjPtNOoB8CK8UNYiuFE
         NUj7b1ZiNSs4FNKrcyxkDIcm+EfxsdFoQjLwWu9BaRdWCp/eiUqZQUJ7vD4O5qZthbWx
         dD7K/ZO6/91HXLheW2zXdvUYBT94Ko6ZyurNnUMzhGe7luPhPIEML38gjGDfDA/pzVIM
         EV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SV+UOXWZyic3g4Zz1/RbKyZgaKJw7q21Zg/+CpfqSlc=;
        fh=5cQT+zWdy4B3BMXTxtYF85T6kMMfs+upLzOBeYhV9DI=;
        b=NL/qH/1ae3MFggLFHcvoPOJpdq3bi6yK/uYr9tPoPRc9oeVAyb1jP8YSaBR3ZgPgg9
         6RpMbyMf0dNYczkRipxopv7yOj3MAHTvf2kCkV0YnuAZOYkFF2W9gxTs4bZUmBbq/wSD
         DLBLSESdRH/cirtxyMBawjEej/NSoNr1uIY/Z1+/vdFa7aWRLUoi93o7XEpJrqf6BHjF
         rkc+6sKrj0ha75LrQpzaEkMFpo7qJqYft6q4xw6pY7i3/SP41a4OFGdGN42JE4+/n7+U
         V6Zcl0GChw9tKvbpBdYD9w3RDqTURYt4OzB1EuoF7n9+iUBeJkOHzmvoyMO9jaVVZx0X
         N3Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1793364729; x=1793969529; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SV+UOXWZyic3g4Zz1/RbKyZgaKJw7q21Zg/+CpfqSlc=;
        b=7wfJXyr6zyu7hW2hUoOVtuqgV172eKW1mLfdsIgZ74/wDM8NU1wvxGBi+RIQAtrDBa
         VolZHYjt/3ltevho/EFRgVROR2ZzyMDPrcUWL8y19RlM3DtE3f/PlhA23vQF6JGIwRLN
         69C02cAlBwo7OUmzlQb9/6s2xrKKAWine9TSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793364729; x=1793969529;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SV+UOXWZyic3g4Zz1/RbKyZgaKJw7q21Zg/+CpfqSlc=;
        b=rGDpD13yxzXOb34Cyol6fbiOzfDI/wLXlCNvRCDtB+nlwvXHVL7w+SX8+5UxYrN+2J
         BgAcl16zTA8hZC8AO55HkpMDZIK2jhXzkKoi2wfkU0mPLwBtUueR4h7cdYUZOVaeSSE9
         NcvKVxBxZL3c824SToL8nKeTs5RpoMGbU+YQ5SIrFG1YWTdFJ58FaBmdYM4u+/DAv6bx
         Dzso8J7CJN2WyZzs1FvzrLc84NLS/9g8iWq+l5N2tuvk/nGyTpgo2hqimrQThZEH4ks2
         P93L5R+olF4+RAIp1wY643VXFWBv+Kc1+PVCr4HfubkuQ3NNWYMgMs0/Mj6DOaRQkn0X
         vrIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxqaiapWvEi8TZfSNcWyZUn68F/WJmzWI5FWAc3i8fuYiZ1sN2kabhYay2/1Vr+fErqxqcMSgp2iwrw1scjRSyL@vger.kernel.org
X-Gm-Message-State: AFq9FYL3+Dk1f+BHIbGVaWvqPx+IyQEtDFr86b6D/s484OpVAsRiG87J
	jqWx7hVQgGpFwFqJSkGC8+gdLHAg9a+BIRvmnLZmj16Hs9zUOD/ne87FgkhKqEB29JlzrqDlM9Z
	5AfURDBYfohmZTRm6+c/YxdN1UpHfrTlN7mwtJT2qTQ==
X-Gm-Gg: AYBFou2ykM5o0v+KWdMSTKw9qq2wWXE2QPfNt2CkX7iyxiiumdIGEeXGAviRADmck81
	vL7iRVNjLHRFlz++Z0HrMJmzuWIBQ+sWATx8hQrsVNdW2fX8rY9UpJGiKjB9HU+1RvQ5wbhjnOZ
	wKHQ2an3lfOo9JABwzSQKji8K+n1zg2bPNuLAIE0puhX/L3e87bffTvKKCDqjg/PUpIj+9z628y
	oysFs3rPa+o4sb7JdBEf4AO5NTcLMLb1yYpgGCP7HvehqKiHWwo58I2yCCBsbTXy5usMuFStIxM
	UxpxZUnkJy4JvplAolOvdeRR1co3uETXGsMuBgALaIOl8ScS5LLNME1lBRTO4k+vkveWgYxKTnd
	zbiJBJ1aHH6zZc1u99+aPHc0pzPNZnj+2NZ8UjYL7lAY+JqLSXA5n8LlE8lWZjU6AM8L2Pw==
X-Received: by 2002:a05:690e:4889:20b0:679:9715:a90d with SMTP id
 956f58d0204a3-67ba4f399e1mr940647d50.59.1793364728799; Fri, 30 Oct 2026
 05:52:08 -0700 (PDT)
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
 <20261027231513.816148-7-irogers@google.com>
In-Reply-To: <20261027231513.816148-7-irogers@google.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 30 Oct 2026 05:51:52 -0700
X-Gm-Features: AclHuK9Oin0NgRVLru_2E_rA0Uqfkpc2FpHOTL7MFA2Wpm_mEuBLadLahOty7wY
Message-ID: <CA+w=M=RE-jiPc7=OQ6N1_51RL5TDWxC+PcXWwQ91djGxF-4OHQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/18] perf annotate: Move struct annotation to a
 hashmap and remove symbol_conf.priv_size
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 27, 2026 at 4:15 PM Ian Rogers <irogers@google.com> wrote:
> +static size_t sym_ptr_hash(long key, void *ctx __maybe_unused)
> +{
> + return hash_bits((size_t)key, 16);
> +}

hashmap.h hashes the callback result again with
hash_bits(h, cap_bits), which seems to leave this function with only
64K possible results. If the map grows beyond that, I think the
extra buckets cannot help and the chains just get longer. Would it be
better to return the key here and let hashmap.h do the hashing? Patch
05/18 appears to have the same issue for the db-export ids.

This seems worth avoiding for the annotation map in particular. After
the first annotation access for a symbol, symbol__annotation() is a
read-locked hashmap lookup on the per-sample path in perf top and TUI
perf report. Before this it was pointer arithmetic.

> + notes = zalloc(sizeof(*notes));
> [...]
> + annotation__init(notes);
> + if (hashmap__add(annotations, (long)sym, notes) < 0) {

One smaller thing: symbol__annotation() is now a get-or-create
operation, but some callers only want to inspect existing annotation
data. Those calls allocate a hashmap entry and set the annotated flag
even when there is no annotation data to use. In patch 15/18 that flag
also makes symbols__shrink() retain the symbol.

Could the read-only callers use a non-creating lookup instead?

> + } else if (hashmap__find(annotations, (long)sym, &val)) {
> + notes = (struct annotation *)val;
> + up_write(annotations_lock());
> + return notes;
> + }

The write path returns an existing entry without setting the annotated
flag. I don't see how the entry and flag can get out of sync with the
current locking, so this may only be a defensive concern. If they ever
do diverge, though, symbol__delete() would skip removing the entry.

Thanks,
Alireza
