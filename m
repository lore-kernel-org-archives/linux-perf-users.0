Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B8F371068
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626773; cv=pass; b=k8HRQpvAlvZQwCDFBuQ3oYwGhhLbcvBzsH5W4QlBpOlAJRSu9IAi0lC4RH+a0NzFNV65v/pu2ZRx00n6+7SKCxTJpEu//3FZBWDnW18quzbpVOAFEQRZKMbQQ4364wukWlRA+OQXZuVgBdSynkQcM4B2UB/HHabV1jTaxtObZ+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626773; c=relaxed/simple;
	bh=ZUuhuB/0J2fpvmMoXKZsjO3MnD0BmMp/y5PlorPBH+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJoQJKxw/kmpWxz4z4x0vvVVYo+wIinPnGV0ZC9lhFflR+XWW/3qVyKbYNk7yvPfBwOrN8eBbM6w74BGN9akXRWeKVWU8X35Y/GqKOJyDAEpkyciou6zAdMYxXzyeYo6WQDO5IwmO0EOEf70/12orOEAfaOu1UHKVvcUyqoT8yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTqFHXD1; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTqFHXD1"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c363eb612so78478a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 10:59:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769626771; cv=none;
        d=google.com; s=arc-20240605;
        b=MOPBVNdHzYWbAK4TSL+FIafoSR3Mxr5p3vMS25h7hae1NyR5mpMYtkrfDvAe7Ugl1P
         c9Yoo8IpxC2Xg9Lub5tAcpmGbEr/rEqa7dS1HJL5ltyfILkm0A9qcJKOXy++4sv4Qy5r
         OzMSI+GQDslzU1Sx8VK6MvmHBtop0i5Z3VwomeAqRJnyqEhAOBizTc/a3ZMlAPbPx7Cg
         ziuVgqOCoTUcVkq/NjsOBjSr715k4187gdWtB2Qy7mEKf79ge0/84zBDQIPgntZLoHx0
         XFYECI5IBNG+CRASpNicy2GEbiyKIVcCQk6EqiqqvWRzGWM1vkvc3NvygDsVMSHj3cy9
         4tHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZUuhuB/0J2fpvmMoXKZsjO3MnD0BmMp/y5PlorPBH+o=;
        fh=V/x2ufdsr4wYb1mU0qnkhinAHVBg9mfNtOi2lqEQryQ=;
        b=Wk0+cg8zWzXgRtiVxr/jkbritOE2R9gCK3MggTt4NcD+1zE4tkraFNcWoaRZVZau7S
         ABLOsF0ZrivP1Ood1nMvPIJll9PA5fEKcO3ECk17wzwkiUU4eiCdO5bLRiFxHE3QRvZk
         k6bu/XS2Y2A9NC4oAuq1JzkeozRfqalJ5rWsfowOKzv6Ln/jywZO7CwPPWuNKohJV96R
         snjOj1dLBQwuFJb2aQ3Qwuqgmhufhh37cIl7M9uaOiNTiBYbVAsAZ9P0td4Au5iGJGsk
         sFPXPvy0OsFVYAL3BNYU34GSp5ux8ZhPKrCXnMRt7CCI828c1LradjQH/ZxNqP+PfG2i
         ppRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769626771; x=1770231571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUuhuB/0J2fpvmMoXKZsjO3MnD0BmMp/y5PlorPBH+o=;
        b=nTqFHXD1cRx5d/aaLdS0n+I1BvN+k0KWXXGjtiu4Nz9crenqITcJXU92RHD7O/xilG
         K9ku6egzSdptIgiDu+shAxgUM7taeGpvXyMLHhyjlcv4Upu7YaOItfFHg8cGd0ui4Nl6
         B0oGDZYf0sBi3MMKtJ19qxlmAhWwmGZg5et95P+86KK0lPdR/bLMi3uQz9A2EgPLKbqt
         TGy462kiLSPd28Gzdj7dYX8gR3RkPNlyZ5+lTT0ma3QJcXqgLFRSJH0tfOK3YFd5ECvI
         y31Lg0srioe1ngh0Wz66k2duZxSwZChbVUZQOdTmNwH/HZl3H51aLiaKakAQ3clGgtxT
         4xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626771; x=1770231571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZUuhuB/0J2fpvmMoXKZsjO3MnD0BmMp/y5PlorPBH+o=;
        b=aC+YHhsnXBBFxcBV+1lB2NKewanyiHpgtG6HpbvyvaGlfOgm5r5Aa2nTWHXZkoZo1C
         rfzHhggRq13aqQIBh35iuK3WQQQeykghNN9m4DuLzmN1WixeUk61F+ySerDcw09V0K+8
         MCjlDD+R4qniknMaJFl/j/2vNV7IV7v52MpGLD3cWDkLXezSO0taVsHR/CHu2UC9ob9o
         7JLRVG4bJeKEl+3KBz5yZT1RuOEi59kiMM1wkKQXZh/BUomvLRPBBPlFTjXid0oNIAAT
         EiGmWz2FfWVjJqH302dVLlN6q0K/qv6E5sxsTWaS2p9RpPKXpp7U6teE8/FLt+q/MZO4
         apxA==
X-Forwarded-Encrypted: i=1; AJvYcCXh4ouZ2/NGzb+feLXxniYqHHxIKvXeVp3q5E3xQTJ7pBQUyZePwGGTGXoJtUbJi3HFV4QZFi0UCYqlDk3U9rng@vger.kernel.org
X-Gm-Message-State: AOJu0YwqWHoTPClRRJLdwTAXi6UEx639JJUWzoMEj8Bb0PPiHqIdftj/
	trMJgdC1egC9Spx1yIKYN3GNHeQhkNHXXaW4nVCdpN/uCyEORqaMfN7apCtgo+teVS073hHO3SB
	rKwmORpthyox2KcWxQIBFcM8y8kZqaCg=
X-Gm-Gg: AZuq6aKQNrMN2DVn2vXTy9Tz0NCuAiNwEblp5g16FQRO331yGygiirATwnnAcBWwB8L
	g1V82ZMy6WjaLBgyNdBqYb0FKFIRM6M19Rwql9m/pSn09HtmruXhKxUG2FubzfJmYpAQv76riQM
	UKPiUgOW622be0PnHp2Mod9m/Z9j9EiBbQxx42un5/zmrUV7hM3tEPgIUdhZ2FbunStxi7Ugm+o
	xmL9HfNsF0BUBZm8cc5Xks9pnYtjwVQzj2P9fSIGeq+4Qqm+whCgdRO6aaiQq+QbTZa6zL+AsYR
	4THHVukmG69MHDRgSEXdQA==
X-Received: by 2002:a17:90b:3c88:b0:340:ac7c:6387 with SMTP id
 98e67ed59e1d1-353fecc6756mr6041046a91.7.1769626771524; Wed, 28 Jan 2026
 10:59:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-2-chen.dylane@linux.dev> <20260128085945.GF3372621@noisy.programming.kicks-ass.net>
 <00fd7c67-dffa-4647-8370-59a195a41deb@linux.dev>
In-Reply-To: <00fd7c67-dffa-4647-8370-59a195a41deb@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Jan 2026 10:59:18 -0800
X-Gm-Features: AZwV_QjkUNRJR2Sau_L0ou-dN1plaIysd0UYjWytfNzLKLYwjuh8FIQT8Px8kog
Message-ID: <CAEf4BzY5tQYSnn4Jwg+cwypnwG6BLLOu6e6=f938d33eSCDObg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 1/3] perf: Add rctx in perf_callchain_entry
To: Tao Chen <chen.dylane@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, acme@kernel.org, 
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

On Wed, Jan 28, 2026 at 8:53=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> =E5=9C=A8 2026/1/28 16:59, Peter Zijlstra =E5=86=99=E9=81=93:
> > On Mon, Jan 26, 2026 at 03:43:29PM +0800, Tao Chen wrote:
> >> Record rctx inside the perf_callchain_entry itself, when callers of
> >> get_callchain_entry no longer care about the assignment of rctx, and
> >> will be used in the next patch.
> >
> > Sorry, what?
> >
> > The recursion context is very much about the caller, and very much not
> > about the data. This just doesn't make sense.
>
> Well, Andrii, it seems we have to go back to the original way.

Huh, why? Peter is confused by your wording, he didn't say that what
you are doing is broken.

The point is to couple rctx with the exact perf_callchain_entry
returned to the caller in that recursion context. There is no
contradiction.

It's purely about simplifying the interface. While previously the
caller would have to juggle perf_callchain_entry and rctx separately
(but still ensure that entry and rctx do match each other when calling
put_callchain_entry), now it's more convenient and less error-prone
because returned entry will record rctx it was retrieved with.

That perf_callchain_entry should not be reused by anyone else between
successful get_callchain_entry and put_callchain_entry, so there is no
problem here.

>
> --
> Best Regards
> Tao Chen
