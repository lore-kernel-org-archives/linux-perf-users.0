Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279144;
	b=gOoIW1oiqwgfzSmI557+ERHGwsskK03gzEcOaJxOx85Hl2J53tuI+a1zIQT/Qa4W6AWh
	 eGOZ10/Q7fxqFZOgo7oVjsP8NoB1fJbivOB3xPTCHcDiXUBUuLUOcKSkIchnzItmPiZ17
	 08LiuappexY4dhaw4FAnQ7VE1HULv/2jQ34qtEicp1TuQA7tG9NN2Rp5SDCfcIzF4m3cW
	 qJg0VnjmLUGNNoTASHogoBqbyqdXajyk2PfdUPElZiUQXRizoygcv8F+0vPzEEcCu67Ze
	 MzM5Ins/RRQW+gK2WjdXgE9vjZTuwtQGIFtnYGUgPv7U+RFAz0X/bnHbaQSgfxBz3Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279144;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=1o3TgLBCn/asTnqDXbcDsKfs5lg9f0d7xH7UA0kKlpg=;
	b=sI2trh+/yYA90/5qGqkd0cGdayT+AMLIXqray26R+m0ICvpTKZvNtnTIjRw1+Te9fcLm
	 4+GRKHbDG8AbJ6EVD9RGXmtntzvm6T82SADIIHjTXi7WwKL0Fag/6STQe6r/MlLdThiMR
	 D8zT5PzpugD7ADpaxpXOOTud8i/ZF0fGIZLiXshNtsum3oMHgQvYNkqGZmuF0PPtLfujk
	 j+JA1Y1mo/W/kqAZwIcLgZKtOD2G06ZFVqwJeXitpXVJtRuNL5zAhhhlPe9Bm2n0dgAlF
	 1vzAOtnfwLMlnn0jGe7XXCL8VQr9ed0w8D7/f47m/DRBSAGADS8neIZB3FNAMomjDCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6wqf0En;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A9860A260D;
	Tue, 10 Nov 2026 02:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6wqf0En
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0531F008A4;
	Tue, 10 Nov 2026 02:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279144;
	bh=1o3TgLBCn/asTnqDXbcDsKfs5lg9f0d7xH7UA0kKlpg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=m6wqf0EnE8iE/PnapG73uZN8YnHsQ7lTKo47z+UzV7ukHwlmqyZzjA5T0WCsR+/8w
	 5ybwBtY/e5o+JZ9ni4nR05cXAjA09aV+ZsVzQ5eXEE5Rw5AmQAXZo8z/yVmz0QtFDK
	 KO2eETCPBg2KETIwmP0BhaXre6xQfqlHIq+aI7QIGWPOdxIKEAA0HlpjIyVZoq4ewG
	 7urT5lzJYtLVkXybWwEX4zQFfjWmYLnCOFay9NwVzvrn4M3WZXqnHV/KAJ/ygDJLCg
	 xYhtjXs2dGQVY1Otxc507+NKaSzk9Wsed6nOvoiT8YsiyNuVHMS9wGka9PSwj6hqpb
	 ifliFSbOJ4KQA==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Gu Bin <gubin@cmss.chinamobile.com>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
 adrian.hunter@intel.com, james.clark@linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261105064958.2134-1-gubin@cmss.chinamobile.com>
References: <20261105064958.2134-1-gubin@cmss.chinamobile.com>
Subject: Re: [PATCH] perf machine: Fix NULL deref in
 machine__is_lock_function()
Message-Id: <179427914390.13444.16238989516543583346.b4-ty@kernel.org>
Date: Mon, 09 Nov 2026 18:52:23 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Thu, 05 Nov 2026 14:49:57 +0800, Gu Bin wrote:

> machine__is_lock_function() looks up __sched_text_start and, if found,
> assumes the remaining scheduler/lock text symbols are present too: it
> dereferences sym->start for __sched_text_end, __lock_text_start and
> __lock_text_end without a NULL check, under a "should not fail from
> here" comment.
> 
> That assumption has already been broken in practice: on s390,
> __sched_text_end shared its address with __cpuidle_text_start and
> was dropped by symbols__fixup_duplicate(), causing a SIGSEGV in
> "perf lock contention".
> commit d8d85ce86dc8 ("perf lock contention: Fix core dump related to
> not finding the "__sched_text_end" symbol on s/390") worked around
> that particular case by keeping duplicate symbols via
> symbol_conf.allow_aliases. The symbols can also be absent when the
> kernel image has no lock text, or when the symbol table is otherwise
> incomplete.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

