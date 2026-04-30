Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0616144CAD7
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2026 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576349; cv=pass; b=ksEUYZjduGMbcKN4WtPtyOHESz+KxYdLFFPGVyb+KEE7kV6G1qSBlKiHYyRpQ1yq3fxG9oH6OSGOoYufL6IuNSN3TCFl+zIIT6/4kZP/TO+0vwk6wfp1FPYlSEu95CY7s7IZgW3cKoPliAShYvSwTLanfcjF6bqYUfBhacR4F80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576349; c=relaxed/simple;
	bh=N8xqxPiz+Lc8RbIzGx9Onv6CwKKtwUHfXe/yYDo0xXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlM6YSjMABCuy/WhnHAHGe+1esPkGl1+GurDzKyBl6/fYB5LN9y5T1WYFp1HYmDoggkCom3FAQzRh9+JK6sP+viurAwUCYVoUVGzSvQyjTGj7Zfn/bkzaIorn/bCejjc1swTnqDlOzk36Gg/lkVlB0PBFBR86pUHV99afPtf6WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E2ObAaWQ; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E2ObAaWQ"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so200a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2026 12:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777576346; cv=none;
        d=google.com; s=arc-20240605;
        b=dtWOTLfMuW8RQdZvfYSE54IPXi8p9YP5u92prLTdJz8jpr59KDjmNErguS5tEhvfkm
         qt+wkWoioWJg2e99gDK5vWw1LyFIIwPNPjCuQRBIQ+qD03AQaJwISFLX0yK/K55vaSxj
         WB2aXSKEEFpLRD3f3IsF+kbrSwvrI/pdqsKa8mR81FUbOhwHjsmIVP76RheNA3RRfC/N
         aAw/8Mqpoo5a6XjlF0xvE15/68/27mMGrCAiPQJrNSj/Tn6RygOEOzW6I9faySojBRmz
         wmWPoPFQO7W/zzgYnOVwZEVW6hm+v10aZjdYbP3et3XLutu9IY9Y1sLSzMPkE2egE0go
         yebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N8xqxPiz+Lc8RbIzGx9Onv6CwKKtwUHfXe/yYDo0xXQ=;
        fh=6MHtcPN+UFcl139Tx1awZ/XCrdhQ22U+8NBHxZOUwho=;
        b=JefZKjLisD1oRvs//FIQuMkGvnZNZmfvVCTv9/SqVqHgModoAtRtglourjzOtSZY6j
         +LpUE/c+HOvtgQ49TNPnX2IUtRF9tbPZLlEB5hO6ZUYhdTEdoMoYtyKUlecLJ3fe0mSq
         UhBhgkQitU2Bge6lj8IEq1NASB4JjLmn7lj2wCCpC8D8xxFTLbadBsvaAsZMbMJUSF98
         6xpAKSYbdoTf3jjuyfKFRFTtIATMat59Loj6UdcDmWYQDlEaj6NK5xhSzV9YpMKD09gc
         dEfFi8sGkvGOhInVvAjqGp5EcSueEM7eN7LnjHcjkByt6RJ62kFEkVMoBufn3w8OXOGf
         PDfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777576346; x=1778181146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8xqxPiz+Lc8RbIzGx9Onv6CwKKtwUHfXe/yYDo0xXQ=;
        b=E2ObAaWQqCJy5F8njMCcuQYFtbkvEgUS5MnL79pcVF+gS0U5yPCgjU4Xvyu1HmuiAG
         wecYrrYhzNgDyY7n8hcfrUsATGvuv+F73GQcNY4SMT9inCxPp8/7YTKrEvOM7AqMeIw7
         A0u1EcllpoxfPMj4+NWM2qGlmIP9AU0aF0uyIGb4SWhMl8LepoUt8K6mm5PDt2UvAEcM
         IjL4aHE9CpEgQwXjt13Bne2cn7NPN9ElotS+DGZ8bFO+Z8d2rH1LIaJJg4kZ2ea2xLxv
         WBci8HIyDgIbDl+WhXxNGe8/A0kbQ38XCdaG0gvgqxuuYUSbheVnYR66sCopOp5zjM4p
         EuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576346; x=1778181146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N8xqxPiz+Lc8RbIzGx9Onv6CwKKtwUHfXe/yYDo0xXQ=;
        b=KIdNm65gw7R7zqkbQVVj3EbOTV9c9GUHOITM535yA1QXcqeNvQOuXAmenxgkZJ5HRr
         6q6ndchJPYDIIYLcu6w7nYukhDFYGTEjhop0qGwS1okR0fzGjkgl3edGrUv8WzNBJaMl
         +dARpm/Rw4XEMKHoGlDhP3gYUG85qvHj3olHSmnLCKTjh1eQK3vdwr5NPuRwvcJQ4u30
         anGjwfOKgZUVM8khKMCtzyI1+wMcqZ22rGC5WVZTya0C6f6k2uMR/aJgD687gOYpX4yo
         IqxuRvH2mkGUmJY5nYCbT+K9btuwz+ty3/0LS8Sjplro8aUwyM+nr+ZfAhQ0LKfiyYx+
         zFSg==
X-Forwarded-Encrypted: i=1; AFNElJ9YFcS3IZRawHuxW4flkD08RuOteo+WWgry4XIX5lRy12ANcy3gUzit30hkt6pUlHCKJKuEgKPj1LfCQZZpDqh7@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl258D2TOMiKFgmp8RtvreY7fvCtlYXFuqQN+AjN9rYuZuhkem
	brArls3qWL70wFw8Z0nEFigV02ROIlU8si6/68p48GxRUI21duJIN2sEHg491UFboe7j8HdNpBI
	KNJqBA2GqjRjcjthRHpjZI49A8uqEbh0WvAVUjng8
X-Gm-Gg: AeBDiesWAeC3pwRKoChzeq9UMC5+djs/QHjm2u2MO9B6GHp35DRRpCIjaYaLbpyPuOM
	/ulSEGvdmNOWWXA0AJthSO7aArkXcFovVKm3JW8fuQKSHRZFJihzqH3WsxaFx+usG3M9a27/isN
	OV5q52dUtHQCcxeuJj5dno7v/vsB7TOUuRQ9PSoQAImXAuxp6muIg6VL3kV7s244HUMA8ddbxO0
	hQmHifvdDyGMfM7iEndoJfEaSk5waCV/pxjD8CGqopbpyV+D+/uDszhXbBFWWQTbuoXaKXKrSwJ
	gI7WY2z1Sjjh46XrUxCdcza/MRvHIpYqz0XSG8rM/nPzWIf/cZB3FdtNbA==
X-Received: by 2002:aa7:c499:0:b0:678:8834:1b49 with SMTP id
 4fb4d7f45d1cf-67b92d3d685mr6855a12.1.1777576346007; Thu, 30 Apr 2026 12:12:26
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429131522.4049054-1-dtominac@cisco.com> <889e4186-9f75-45d3-bd9a-1c90b218a635@kernel.org>
 <afIiqR5CqYRId0N0@redhat.com> <afJz3l6435DHLorn@goliath> <afMeAs6upm8kLCYb@redhat.com>
 <2d815203-a81e-40b4-92ba-31832c84c20b@kernel.org> <afOjk9igx9nlc9cg@redhat.com>
In-Reply-To: <afOjk9igx9nlc9cg@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 30 Apr 2026 21:11:49 +0200
X-Gm-Features: AVHnY4K-YxCsSWEfMM3euP0MFRxkho2vVQKGYi2YKLesi4gZWVCDrwbxNVlDvgE
Message-ID: <CAG48ez1B7ubv6yJWA4CoSm3AzzyiNHzcAz0ByX_VhCqaA+iQTw@mail.gmail.com>
Subject: Re: [PATCH] mm/madvise: preserve uprobe breakpoints across MADV_DONTNEED
To: Oleg Nesterov <oleg@redhat.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, "Daniel Walker (danielwa)" <danielwa@cisco.com>, 
	"Darko Tominac -X (dtominac - GLOBALLOGIC INC at Cisco)" <dtominac@cisco.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, 
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 8:47=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
> _In that case_. Instead of this patch (which, rightly or not, I personall=
y dislike
> in any case), can't MADV_DONTNEED paths check MMF_HAS_UPROBES or vma_has_=
uprobes()
> to decide whether .even_cows should be true?

The manpage currently essentially guarantees that MADV_DONTNEED
discards CoW pages. I think it would be a bad idea to change that
documented behavior without a strong reason, especially if that means
we'd have to add more special cases to the UAPI contract.
