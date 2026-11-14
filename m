Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794673850;
	b=cItl4GNUY5s1g2SvheWj5LdQQtWpz6PnRkxihcH5TLiCsuEbJxQ5PWlKEzS8p8hvSka1
	 gU57YGhK8Lvj/IuEi+CVTRcz+CgIhlsZ7ZQ+tKtBoz6Ut3JIsIYCT2603oERp13/fpzNO
	 qs59gj+JKRegU4aremUMS/qF7i4ybCaQzEVDNag4+o6o/sJCQvwTwqpnz9qKEIQljbBrY
	 jJp5SGTKROptNeoOIMcK7d1NeIlFKag2yJrV0+QMK70t19dqmQWYOMgNDuVsB7I5aQ4Pi
	 JKlsy1kJuwN3uo4AeA2l09VcEWJaQUUJ6p7qpRfAqCrX+2tfXwzmuL57Kk5ij5NU9Kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794673850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=fGWxKs0ygx50ezpgbkqjOUBZBQlCGRAkgSt+Tpagf3c=;
	b=RBp8lKBLZoCNpgrls0D+6vnA4+U9kUa2EkuGnV9oLqvfy1MxgsRkbNNTDMpc7rGHfSyL
	 s8RCx6/ca3MEGc9Ynd9ADf3xVg2CFuok1tI3oQUS0aep5qWlO133G5E/WqqC07aNv7dHw
	 +6zuJYco1rG7l5OSNUraLRW/qlcWKtHqswzEp2ahVR4j7r/n82ZQlTCgNN6uQWM0UluR/
	 Qnztt2SgKD42fTHHvghnECbYKbWfRNaE1l1oMayhAUKeLj6e5FzOSCBSrnQBkwe75aXw4
	 42xASJ3wajYsZ5ZOYa/sGONKar1EqH1r3ivh96VzBRQfZUgCFO5cYX1pq/yLLHRzBEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=i4ZhSP5o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37F9606A329
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 16:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A37F9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=i4ZhSP5o
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b4c2da74c0so1603967b3.1
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 08:30:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794673849; cv=none;
        d=google.com; s=arc-20260327;
        b=p2MbfbJfYtdtgXo5qk3/Y4ra16sONm5hWHjSUABc0Wk85ceCRCDF1ylO+t7mJ9XNUB
         0QkMWQ/FFdsHI6vDoXTn1uxfAH58riAXJFOzSmTOj7L6qVPvBtcD+XtCus7jnksTNsFo
         Rn2mnrePxu53rr/fbISQFYJ3TQ3STxNWYtHjRTg1JWi8MttdAtRs4ho5eRZihYgLnneT
         gHD6VIsSIyEo/gpJraA6AViivDdqWPfltQ62WvyWcnsbXE/3Os0vfYP2Rqj/l9cbdxt9
         jrGne5ew7v0vShHrFEOE6c3Wfoh5P+JMxOF0UACoSDpHNbbD71k12UU4llf/jChS4xKx
         RJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fGWxKs0ygx50ezpgbkqjOUBZBQlCGRAkgSt+Tpagf3c=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=WZbeshRSzoeMtTsFyiy6J2LSM+cQXL/bM7AOxDJMagH/wZp71McOg8ZNFtC7Fodwhy
         gxCitS6+7Nt9MFxDdTAfPmwEkIZcmLcoCOZ6PrH5lcvhe3enOdhi1gxpmU9H52ADFr78
         inO2Rj5qcQJhn5jRYOvJ92N9HFqMXPveQbxTPdAg/qbvA6NIi22hvysWVFVtThpp/hFf
         uBQFk5sbNpY1z9dXDf3CneuoOTpt6DsuJ3x98+2+g7f0r8OG/t2CF6HZdxR9ZdH2YobJ
         9Yg6kByPUnFyXYxaYh6MAESf9X7IPc6HKQSzdksBPEwkW9tU1rapQKH3DLkwfNO1x/Sr
         06Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1794673849; x=1795278649; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fGWxKs0ygx50ezpgbkqjOUBZBQlCGRAkgSt+Tpagf3c=;
        b=i4ZhSP5oXiQ3T1CerJIB+TQSq54f1qTsemaIa3/SBpZyykbgE6psqWjcgUh4b3riwE
         XQRebrM3n8slgNf8a2Ms+5onwWT1NQWPWBR8tqkKlanMuJl58Sf/SpuVXwmYBwRu6KBP
         U2WMoUxX4lW/6k5DGE+p5EUen+BeKG48gWbGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794673849; x=1795278649;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fGWxKs0ygx50ezpgbkqjOUBZBQlCGRAkgSt+Tpagf3c=;
        b=SeOZkRmPP9NXWRdOJtqXqEoeNnKhIt5R4vp5OEQ3mFbBqFp35uv8JjDF7Ej5l/wwX2
         bqDREoMS/uIKB3kJv0ZGEizmjKYjNocLwpZwxo80rrYqEs+23DlqnYsvGbAauxghYq06
         KDJZNsz/ADH9eHdxW3n5vSNU+KYaDni7qIgb6ZLq1rmX0j9Pju0QmfrwNhJGx+szOeMI
         hvt9Pam2nMuacRp/93DgBwgkidyDpp0ORjvcfE9Mq2IuiNEzKtS7o9/odCqqSZoNX5xs
         nMRikzhup+jErbLuUiUTEXM4POytlS9YTIA0hqZMLEZAeREWr0ahoEblZRjMgTOD+xLn
         2+Fw==
X-Gm-Message-State: APuU4Z8pr8bCYoPjLcMaEMn0VKa1PQhKKVXrl8kCAPTjjXI8oE/KRAO6
	fLsdFQAsE0JdL3eQhVUG2rpRtAvCoVKjyMw6yvQTUaskwzG4AmbxIi3sG7yGm7N7No9o6JbiyXM
	Nq6/pz25gKsBjRRWFCJfEmkErIeXWe78Sxv3vkYUWTD4zMfQ6NCHcOyu5BWs3
X-Gm-Gg: AYBFou0xcCsCyusB3Bxb+nH3XSH0YiXDAVwadlNXaYIAJZ/QdXz/YicFZi+JNwLHWj/
	K6v4wMPNNSGDqycp4Azboz3UVVYQlVclLEvRbg9Oweu1O+Pu+WolbZNWlaNrNlJW1Etxv7PQHQN
	p2FfukhO7+ABNNj5DJjTPE3UbuIgiDso0A/P5eL4Jy66XBMHckDdpajOxURtOKuNKJFAZQO1Syn
	4D2nJ0U8YF2j4vyZL430YlhBuO3DLZ07eEE4ypVDB40yyb2cdLHzwBhnxYqTcqd6k+EL7lYSlZ8
	G893z9xyPTEFzae6WyCesVkVAEgyOr2pUbz5hIzWxQxrpVn9/UjUYqupLH3b5dWpXojG+0o0bKx
	UMGxfrWFYandcjZW43rQfLIkhl7/VJtNK8SvUlWHMzavzcJYgVeGkVCQvHy1lCiMObQidlA==
X-Received: by 2002:a05:690c:f03:b0:8b1:8aba:afe5 with SMTP id
 00721157ae682-8b4aa2eb937mr32268107b3.28.1794673848298; Sat, 14 Nov 2026
 08:30:48 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-perf-symbol-memory-send-v7-0-d992eced9f9c@uber.com>
 <20261113-perf-symbol-memory-send-v7-3-d992eced9f9c@uber.com> <sashiko-outbox-214179@kernel.org>
In-Reply-To: <sashiko-outbox-214179@kernel.org>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Sat, 14 Nov 2026 08:30:32 -0800
X-Gm-Features: AclHuK982XcYJYA8AaQABqiKfcQLmXN3r5fAt__j6RIZF2emENSLWSuiIVJOgKw
Message-ID: <CA+w=M=ToJ-WYOZc4GhOPNDF3cbu-bPuCqhbMqvQMZL+pdOmuTg@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] perf script: Add --lazy-load-symbols to load
 symbol names lazily
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> [Severity: Low]
> Can skipping the .dynsym copy here change how symbols__fixup_end() and
> symbols__fixup_duplicate() resolve symbols when .symtab also has a
> zero-size symbol at the same address?

This is valid and I reproduced it with a small binary whose .symtab
has a sized function followed by a zero-size STT_FUNC label at the same
address, with the function exported in .dynsym. In this repro eager resolves the
address to the function, lazy resolved it to the label. It needs that
exact layout
and symbol order, so I expect it to be rare; it does not occur in perf
itself or in a profile with about 1M symbols.

I can fix this in v8, add a loginc in lazy_dynsym_copy() to skip the copy only
when the last symbol already at that address has a non-zero size,
so the lazy tree gets the same fixup as the eager one.

Thanks,
Alireza
