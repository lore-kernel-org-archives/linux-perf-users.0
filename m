Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57CF3612F6
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652574; cv=none; b=Xo6Z8mMuNrX126ZXBXrab6UipnTRwnsXidLv8XSY+XyvL78PnHbheY9pg8fQMuA3GhgLrfpijlbKPpV6keo2oT/dcXmSCXnX+cXrfr4tWc+QU9Zf4Id34PPjaMlT9Z7ooykzer0dhGt0s72NdhGzHbnDO5P1yLHtLtazBJYKmWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652574; c=relaxed/simple;
	bh=fKeSQVm9UzUuhq3H7y2QxxDaU89CuSYm7tZU3NJiUkc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPTvPZpAxKP2+Hj0GtWBhWoZ4CiFNWJwh6eYVJn8zk+ErPmDKFVDDC2Mo+8Y6kShbVXOhaF/7rNh+izxoDMsfU/XOMxPW2afXCb6kldG+2drEBnUPmEg8L2zT0erYAagt0tZ8v1fBpK3cX938a2eAQYC5ouUBilWUsuvexfttV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgW9fyI8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgW9fyI8"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a041eae5so33122925e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 05:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775652571; x=1776257371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCiGh/TAopmTia/e16V2uyYbOgyzJf5l79QanUCh3kg=;
        b=IgW9fyI8qB8jmz8X/rMlR9R+EW1h431jhQTJsWwwtszEbG4NaEImGSG7Yc8EVLKYt4
         m4NfG4moOOoJQ1pXwErCosYEIVoSZiUog/dPLqIo9Cbf+HqAzaV3ZUYG5cy7EbWmfDnx
         OctqTyK6Qh7sLkP2YXL8AcK4PmaC3sWAEJ0Aj7OKPvxE3SLKgKDBpv2jJAodRX39SP3n
         FH3m4kzOtGehBri4ww55t4ON0sYOgp13XZF7QMvS2t9cdPij3YJdDO8iTP1BN/6fxUFP
         hA8usDEmtADoSKNiooBYpCzvsP+/44ZGKkZ7/jVMY8WuEVNRCqNuCjTEJq0VQw0kvUOW
         zKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652571; x=1776257371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DCiGh/TAopmTia/e16V2uyYbOgyzJf5l79QanUCh3kg=;
        b=Nyi26EgYRtOeT8CuqayK+OMrswdnzBEivxc52y7/jq9CY74cHUz9TGYrrgyRCXDhvz
         RXeXR+0fvB8zroZUtD+BB8tuWrhwhYzFGXy2V75b+RwlsadUU42etuBZe5j5umW1xvOo
         LUWKVg+IZo6JVyYrV8UnUoZcyxa2nZOMvf8lg2+nMPYy+myCuVTQ9XjV0qp0iogQp8el
         dik/N6LHS/PmreYiRprytM3mEAB00Bwk0UGO/j5t43qFKnuw/qjeiBXFBobxzvfUhJ+U
         NossR1l5wo8scCWH7fcxAb9oEzLFL2aeJQZTF3c3ExQeCbCEqEo8CxeihEnKzuPfK4lF
         mmjg==
X-Forwarded-Encrypted: i=1; AJvYcCUfdlm1B714UoIjOz45HW47yHj2nk/HXzVAVQaECeA2XbRPYlEz95S7SQntH/FFzbKsz1dI3Xl4Q9+dA+d01QsN@vger.kernel.org
X-Gm-Message-State: AOJu0YwmF8xS9EvylGP16tACRixixr4LcDveS8P9rh3tDmMoI3urhoh5
	mr9o2VFRWG7ecXTV2j7yXyelGJ9fk991mg4gOEdIlcZNbFvzFMEi7juq
X-Gm-Gg: AeBDies0ZrhaMNrCmEgNk0ZOnIlmrQVWhOCq1ZG1+8vect7w8qTSNtQ+WuAKIMmPBBU
	taZ/5IJOaD9JKdfCg0AMyjTc5+0ZJoyN7HA0sR/lD410nKB7TcLxgnfJ4j/jNlL9Qk8YrRv4k8X
	3hcFh81+EgRflJ1bIf85nR5YGhZ0YHaQ6iIGeKmwEooL/BF2l5Su2gckjcT2TBmzSDvDphHeMCF
	/ZpjTlcleElaY2sWsckOlHkv73InXEU8t7IOO1iiDZHPtlYdQdWDjEnpdvsp6QdZlyEwy3jrUxn
	05+KaMhR7Be60KFMg6btXbPKPHZXu3v+27muHvQobwJ9Ci6PRtu5mmVPw0Um9hySQSns6/VvVDX
	wZbomkYboBQiPnUfyok07wzRpX65vdPWqB3RYvMcPMFePovGtbANQbycpMBUSfXrJ75PK2HNM14
	bfWW751O8hCajdo/7FF4dYVTLa5XirUpp0VOQw5J6Q7MwsSGLySFrArPk20usxyy1bGZg1t+i/+
	Js=
X-Received: by 2002:a05:600c:630a:b0:485:2fe9:336f with SMTP id 5b1f17b1804b1-488998e3cbemr296043305e9.30.1775652570938;
        Wed, 08 Apr 2026 05:49:30 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c5dc5fefsm24994505e9.7.2026.04.08.05.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 05:49:30 -0700 (PDT)
Date: Wed, 8 Apr 2026 13:49:23 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, David
 Hildenbrand <david@redhat.com>, David Hildenbrand <david@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/events: Replace READ_ONCE() with standard pgtable
 accessors
Message-ID: <20260408134923.3a44a703@pumpkin>
In-Reply-To: <1267a6c0-f8e7-4708-96da-4d131b5c6069@arm.com>
References: <20260227062744.2215491-1-anshuman.khandual@arm.com>
	<1267a6c0-f8e7-4708-96da-4d131b5c6069@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Apr 2026 08:58:46 +0530
Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> On 27/02/26 11:57 AM, Anshuman Khandual wrote:
> > Replace raw READ_ONCE() dereferences of pgtable entries with corresponding
> > standard page table accessors pxdp_get() in perf_get_pgtable_size(). These
> > accessors default to READ_ONCE() on platforms that don't override them. So
> > there is no functional change on such platforms.
> > 
> > However arm64 platform is being extended to support 128 bit page tables via
> > a new architecture feature i.e FEAT_D128 in which case READ_ONCE() will not
> > provide required single copy atomic access for 128 bit page table entries.
> > Although pxdp_get() accessors can later be overridden on arm64 platform to
> > extend required single copy atomicity support on 128 bit entries.
>

Did you consider enhancing READ_ONCE() to support 128bit accesses on arm64?

	David
