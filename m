Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E071399D02
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589610; cv=pass; b=bzOMMV3UFs5T9xtmbf8DFnHWX0sd9frboG26iAhXPNxmrO6anQktiW48gYOc3XwrvVz8zQYKeTxgxtgY/2SXzI9BMFrW5S557+K6Xlzu/bpRmL+Y/JSNrnzLqAySrgtdrXBM9hqZbqERRW8d09O1ERXvwykx7wUskFYmorJ9HnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589610; c=relaxed/simple;
	bh=ZjnY8vIhRprJOct81kjjG0QGweHvVimxLsEl6GOTCtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFese7QuXjjIZMUJJJ7OqTUjAP1pCWgLQkXEQvBXWidKeQahR6qj1zotYRfbUcpTeOawGqkP59Wvw7pvzac4gZYe3qGH1bYZwFTjTgss7uwLNxAOBa35V23/OsnQKpoAPgJxNmn0PcCE97X9z6QTyBUvkfPi4+1MvotHCM2yFNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t+WQjrAU; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t+WQjrAU"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso198a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 05:40:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778589598; cv=none;
        d=google.com; s=arc-20240605;
        b=GAwnARm1SK1WOarfPl7UH2Rz9+hnmauQ62ssPi98H2pASz59QZYMUePWwYUl+Snqly
         2kdqgHLWCGqizZRyOF+R0nfcfDAlRgm2xD1ee49j+cvFkkHBa7mcK2XLuteDXOnG0QDd
         I0Y2BCI89qlIRYOPi10Qizf3HpMP38sHGwMeSXmZpawhROijTI2CQazN5OLwD+LX3c4J
         5XFRoE815ahRu0kN8LO02zK6TX+NV82QNVwpDqSW5pwRb91394X9yEeEPnxoc3M4icDa
         TuqUcy248UBAs0el39ZA5kcLP3vvbbzEYY9u/eqqBsh6ASpCZH9lhyjAvW1PRyPe++IE
         Ggug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GZKiNWlWL2FAZflKzAl5phrZCGRQJtgrE7BPel69owI=;
        fh=LiTUwEAmpUgT44ceT4sOySG/zcVKwY1733XsnSHHyPg=;
        b=l1OM7VySsbQ/UHWPqg8EvSZ5Gc0w1BI2JGy+llqNU4jm+MhIZvORK/geLb11EudbYj
         rPQ+QpEeQc9sYPhjm3fLUiFno/RuIMyvairDhHCEaGXBGtdLNjuU3JSEW7YP/9+VO2OM
         p8ozBtMsONJzQBPXEQQUxbubm3MlOoRNTrstft7ZpE6/Jyq0QEB3Me1Ev4Bp5dMz9mvS
         ozoRn7Iwu0GWcWPUK7gZcjmkVLDWl3nY6LTb060ZeDsfUjB3Y9YhfgzgY8crbQKdaPZ0
         7gnyxAgzJIeDzXGGhESChoVCX6Y0PIiOWYG9E0CXVrrB21o4u2OMSZ4SG0zxJa2Tv9RP
         2ofQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778589598; x=1779194398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZKiNWlWL2FAZflKzAl5phrZCGRQJtgrE7BPel69owI=;
        b=t+WQjrAU0yMoz/73MBtW2am2mOoXDtdLZCwevLTkPiHNM8X/5GJwcJwg8PW8Rox4DW
         qAENuuO7gLDo384Ek26I/EgF5e9zNcHykCsDRhj3CDhLKe8bGM3gBZbXV2RTCfj6PW2z
         UwF13tI0SMf/WyOipLXntPNmX/eieX6lqFdcr47lEGnh69pfCPt5aJQ7z5qFtWEzJArn
         lQdWEiAoNNKL1RFhkbBsYUcqRSFvDk+pz4qiT2p7Ci6UoXziZ+gxpxHytYaFJmebz7hm
         Cccq7U4+uZp9rirmjhJh1z2Mz43QL9cW6ycqb56CJJFC9AIax2hYzUUimYwEL4epiWcD
         r0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778589598; x=1779194398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GZKiNWlWL2FAZflKzAl5phrZCGRQJtgrE7BPel69owI=;
        b=mxVjZOSNMSbsK2mKc06KyG0k2C337KaOH5/fPPCqiMCdqJruHlznyT5JeaYWmxPebL
         O/uX9g4LlbW5DfxkFv9k8e8r0F0COOyIDLfd0ypeJ4FBzUhHmWrNB7MmgVKpyE5lQSh3
         6HlfdD7RJgf8e6J5MKkZlVGybLrEtiLOZRE/dkkrR82HkidOUk1RVg53hIltpaBm/F9C
         mYWLahWkebqAjMyKUv3o24PTL8rdkuWshv5o7p559rtUggNJw0p5JRFZOcTAVtyg+oJJ
         CUgi1c98guvZk6Poqy0Kt2QNdjgvCbeWkeoV8pSQqvC4QV0uyZC7SSl0RWz24Fr8P/JR
         ocKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/pfiHPHRnSHv2LZq0OLctQ2TCRtTB0rWyCcHtVgo766zkDJCsn+cGYE3vlkKpUdXeYccqY50C7fYQJdBN5ad8T@vger.kernel.org
X-Gm-Message-State: AOJu0YxAGbeTwmZucz86EmwjVZvVFwJeMCc99kzWT/omGmewrrelHTcW
	+a6g+3T9Qau8lI0sIa03ksACc4qxyl8lsyk1NkbHh3Csf8qiWYu2ikyRkPC28PcQcxnKW+ixSdF
	cwbnS8TvZsD5uxbJS77ALCpxtRbARD6DsQwqlIg5T
X-Gm-Gg: Acq92OEAJlftJYb5pRCy1bVZ+3DPnsbDa4H8i/7FjCiwwcKK6Q8/NpDNLCwlKerYSOU
	GLROtiOaSpF6eIiTYQXwc13vX34zjWxxLfZVXame54kKd+2ULVSkMYcbMdWE/nqAmXFCBoF8KZz
	9HQVUYMbzb8df0csUo4r+593mFfw40h9aaURtzY801gBsZwEeo0vqkIvqlpxUU0OFzBrMHngpLn
	K8wnt3HzcTY0Og90O5H8wxe4cVv8h29g4czvepnNheYGnbfz3HjKrMmm0gGIn5dKp5UyQsfNq/P
	/kctwy9G3msmiW6jsw==
X-Received: by 2002:a05:6402:160a:b0:66b:e078:5934 with SMTP id
 4fb4d7f45d1cf-680daf097a1mr34294a12.12.1778589597723; Tue, 12 May 2026
 05:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508231353.406465-1-seanjc@google.com> <20260508231353.406465-5-seanjc@google.com>
In-Reply-To: <20260508231353.406465-5-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 12 May 2026 05:39:45 -0700
X-Gm-Features: AVHnY4LX6uhXx_8fzCenS_BE6k3foQYYVMRhYxLYCauWDZIM_aClZOiuzSgeNIc
Message-ID: <CALMp9eRcOMSrrtp0SR+hVLAKaOu2AWKJnpGT_51mQ2vJOJpzfA@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] perf/x86/intel: Make @data a mandatory param for intel_guest_get_msrs()
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 4:14=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Drop "support" for passing a NULL @data/@kvm_pmu param when getting guest
> MSRs.  KVM, the only in-tree user, unconditionally passes a non-NULL
> pointer, and carrying code that suggests @data may be NULL is confusing,
> e.g. incorrectly implies that there are scenarios where KVM doesn't pass
> a PMU context.
>
> Fixes: 8183a538cd95 ("KVM: x86/pmu: Add IA32_DS_AREA MSR emulation to sup=
port guest DS")
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Mingwei Zhang <mizhang@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
Reviewed-by: Jim Mattson <jmattson@google.com>
