Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182A71B6D08
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Feb 2026 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770164676; cv=pass; b=P0tQUKzKZl+tB9xQLKzYkAhgWAgHS/odaBakg+6TKx60MFXGwtgYmJ9xY7U0uqwqJ2OK7XlnmA/2OTOzI96YY24yLRriMlaZ/CnP9g6kBtbyl3tE/mfT+02/N+YEvlCCen6w33CbNSiYCkFKdmbAiGjIpP6tqnjHGecgm2+6UqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770164676; c=relaxed/simple;
	bh=0XowqUthzIp6AMwUt0j2ogPOeD4Ty13T4iN8EBzWpVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxVbkVOwx6PjfEZFjIgsIncM3ESPfvJ51ehX+urxVWezn79p9bmDIFmKuPZF5nV3ShTGZ16JaswamGnSx/8VKFvWS+6qMLo5an8VmuvhRf9omqGi8Fo6Nc5R3xO8k9ajmL9oVCQOKSqsBSB+OMXsCt4iGQiWYbXQCABi5yC21AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JR8iMIl3; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JR8iMIl3"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-352e3d18fa7so117856a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 16:24:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770164674; cv=none;
        d=google.com; s=arc-20240605;
        b=Gcs7L/FW2iRNUIw4Tkz0muART86PWO2vJObxQB2k0GsNCFRENJpfIhr4J3jIilZgLq
         29qC68qooDH07myhkgYOEHW1q+cXDXCPQSB9WPwEOCIFGF1M5gb8VYXMV8pF1psQ4Dd1
         IsZpWXYU9Z8Foz7n15Yz3LQ2RM7O+/OW2IVIQ8mtAnpWhE9/yFVd30HsrdmOA0ocweTM
         pYR/6HBzuYd1iHW5qYs4eH01cj3ry3WyaonUEREl0WcmMuW0cf7pU94zRafQ+ujCf6Rd
         s7x0Sh9H2MkFiYLHOkmNt472YruUUdj12FkLHlnv/HgzNsMZ2Fw8yCKC9M4jYtBLmrSI
         Qd0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0XowqUthzIp6AMwUt0j2ogPOeD4Ty13T4iN8EBzWpVk=;
        fh=71g5FevR/q5sD/G2r8Zhn8Qg69TPGWAsbSPOcuhXwJQ=;
        b=R/kCdHmXVLKGuGVa/oyTYRIC124XRomCZfGqFCPwngoyRMI5+fbhA3hL5+LOWMtgYX
         Bcjg2rE5K1zHicua0ezUXX0ib9JYsopYS5KUVL/ZEhqkhyTPn+2plVvdP5e6M48Z1Q7f
         s7UiCQWHbXPQvdFL3BbG6hoTnlMLKqA8DNdqd+xD+kIajRcuOlrAluby6tCQ2cF0aiBm
         3/kDtPKem7w/ewSMY6fcrNP5fjYLbVGhWbqoQvWuKRKLGed1p9cpcmb3BGgdiHXSBYsH
         7zQFpbIyeC9THGhGy0CTqmV3RRkCBCKr+po/K6bJxT4U8N/BIIRPycWDT5DX7XzpMmqJ
         x9Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770164674; x=1770769474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XowqUthzIp6AMwUt0j2ogPOeD4Ty13T4iN8EBzWpVk=;
        b=JR8iMIl3U0QLAJyKUVSI8SE78JZXBqO3ZwkNDMikk42XvdutMrUbtTuqHeQXCgEJpn
         Yh9qpWPDQcUwow4/yL3O1wz39crY9GYERS2Uq9SdPCpQLalcE0Ok6EsSqSE7Ix5NFI+U
         lKyzxrAtB+gvfedB7O/Ja8cYPcuHFY3PDXJ/P62ioXTNKwEqvzud2/bxnItdrP5iLQnN
         fMYa7bSuWAt2lS+HbwrTd8313SK7UUuIlFSaAwOHYNDbzyMFf69wRnJG5s+UUzDqXrrJ
         02zNzivvAYjujv3X5+8GpGVMKXcKc3IWGnsY23f+FQapZniRBigGo0KfaXF28CsBcwbZ
         FCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770164674; x=1770769474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0XowqUthzIp6AMwUt0j2ogPOeD4Ty13T4iN8EBzWpVk=;
        b=t7AC94hZfd3mEyq4VmEO06TEsl3y9loK9ot/3zfhWb19ApAZ6wdvd4f2lDPo4XHiis
         XsvmUVF0M6A1EOAsBWEFOjoDCdcwCiUrexCwYXwejRwWTLZiVR/cFIZfX+ixRIl0RZ9j
         My53TcsnkKw6+P1DUdgL2i6+QIp13IcS07NuhP9nG7fgyGYhYNqU3rWAdua8irSHgjUZ
         oMumU3sDFXtqDbLIEqjddQKwbHrG8kR/ALkCnex7AibYsPWBW7k7m6+YQWmpjnaO96Q0
         DG6Fyiyxix6lcEL7IH515bcoerbD4u++sj/sy2XGuvD7/Q9mRyroAzEIQcrAHcl/s36O
         ljlg==
X-Forwarded-Encrypted: i=1; AJvYcCWDLRiaqUrihhXdedZBo1U557bHORFjJx4PGxDAk1Nlfndu5XIKnS0H+1lB9VlYdJA0nPhPd84jhEb1hHjJRzUk@vger.kernel.org
X-Gm-Message-State: AOJu0Yym1EbuN2eqJu13GrytdhRY9ES0ZG+l/dMk0A0q2y6BGJb1VHWH
	hMwrRElZJtUj98HnBgVsvk1bUoP/g9piJ35nryH7um9mPtQTyovIeYPVw1n1xFBYNlyXkJr55HX
	cmC+XRF2z4/ufe4KwOUDcO0D8Om/byjc=
X-Gm-Gg: AZuq6aImoNpUtaWbhMQENHyW6qUBVwnXElc9BXr2+NrzkiMoYVcMvm3NTGS6dCQ7y3s
	hZn9y0lCdy+Ae6b2hsoXWP6kCaG4BqAk1vSiS0c1F9o18OXUsLn9sjkwd04Vy47yRgLKZFJbNua
	bGkQyfG2jZs/8zuDi4jSTCOfADj5A8SYBUAP5ubk9gtMnpxTLaaefkKr1yYyIXuanOLEEHZ9vaQ
	jPcgodBST9F167g1w30PnMPpXBjm98JqlC6xjie7aFrf56R6VA4N3oR6zO6CdQhra5Hl4wcUTf+
	2CbZlas3Xkw=
X-Received: by 2002:a17:90b:3f45:b0:33b:dec9:d9aa with SMTP id
 98e67ed59e1d1-354871e45d1mr755074a91.25.1770164674418; Tue, 03 Feb 2026
 16:24:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-3-chen.dylane@linux.dev> <20260128091033.GG3372621@noisy.programming.kicks-ass.net>
 <CAEf4BzYpcgC0Pi0f_ScUavJ_Tw74PKULsbPdexKsWmb8RmxLKg@mail.gmail.com>
 <20260130113150.GB166857@noisy.programming.kicks-ass.net> <CAEf4BzZNOqxhkjuePzeG=ivqBSHXnWzPLPPHJdoC91c+u-WjAg@mail.gmail.com>
 <20260202195943.GI1282955@noisy.programming.kicks-ass.net>
In-Reply-To: <20260202195943.GI1282955@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Feb 2026 16:24:22 -0800
X-Gm-Features: AZwV_QjfrlFp12nEWIHj1VnfqarPHZheZpDK4zQAPFm6dulsBZsc44JaGkW4kNM
Message-ID: <CAEf4BzbTLqzcrbyfLmhB7b9XZHLPno+YfZtcw12ZbcwwaAP6yw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tao Chen <chen.dylane@linux.dev>, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 11:59=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Jan 30, 2026 at 12:04:45PM -0800, Andrii Nakryiko wrote:
>
> > > Also, there appears to be no buildid caching what so ever, surely tha=
t
> > > would help some.
> >
> > Jiri Olsa proposed caching build id per file or per inode some time
> > back, there was vehement opposition to it. And doing some locked
> > global resizable hash that might need to be used from NMI sounds
> > horrible, tbh. So we have what we have today.
>
> See kernel/module/tree_lookup.c and include/linux/rbtree_latch.h :-)

Ah, neat idea. Each node is really two parallel nodes for each of the
latched copies. TIL, good to know and thanks!
