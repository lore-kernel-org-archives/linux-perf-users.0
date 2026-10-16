Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702D64E06E4
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167485; cv=none; b=L9UG2jigPp0atgydqfcyE6sQ5urUTTYY6BIf0t1CzqsoJBihL4BX62LTSRgVK3qKXpcbr1ItT4c5kMOVmFpejx7yMe/JPPqiGAwJ+INXSnXOMSYYBq3SsrG36bB4E3n6RSyXYmqyB4y3OjVhFS5YgMG3sjc/5G5M28keR1nk6hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167485; c=relaxed/simple;
	bh=nZWtbApWt3kV026dkoDNspJsmQaxaHBVELtY6w2UgGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFvknYaKvJBdVuGXMfmMbuh73YwIoRpcOBt/T5fOsdLdxgc0FUz2/Lp+sITfka3IoyOkRXRK6XmubFTo5UAySts6XqjLFKLFiVnctWdzfcI4pyaZryOeUF6bF1DJ6fLrkk01BjIjSXRK+YJ0ckXEjJBy/tIZGtkEjOsaNLllYY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M3CpNeiv; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M3CpNeiv"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-82478760557so2453054a34.3
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 09:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792167479; x=1792772279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/aqB/Mmx2mmYZsJMDrgp07ogosIeUVeJwoNnZHzHvsY=;
        b=M3CpNeivZfD2Yrd3gUdREx/HDMNqlNOpX4xlFZRopPaDnqpqK9FF4rNZG9bBbxuPtx
         rVUaIiM31BfaYxDtDVTibXZ2LufgGbCGDw0tKWMYG18+sYEZTrZDwXQW6qN8wvLackjD
         3eA1+y1A60rnAfmqUeg3bK8FhHqvKWEQDU5u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792167479; x=1792772279;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/aqB/Mmx2mmYZsJMDrgp07ogosIeUVeJwoNnZHzHvsY=;
        b=yLk2A1lGfejZjCKXypYFrph9hg3Kjz63ceoXnkjdF8YoyKpqltvNzpvAMPrvPfMq8H
         RY+1Wzx6qxXhCG1p/FwTjWZzRLa7f08pWzJ8/Lr1vEIHTGvhk9Tgr93zH256KNgyNLAj
         84y47580p4ivbTK165nYVLX8h0TvSxmljHiINO/EJHdoXUI2GqnX8uNNSjYynLFJY3uF
         bKFlmbaxe8Gu3r3zDTMlvehZ0PeNg8GoDvCTNNSR+7IeIsXMATjAFwLemFTw61UAFmWX
         Mux7ev2tKazZmdJkiNkfZ84o2teQY2yJb+pFlf3F8Ji6DaGXmEt304DAJxyv0oJYy7gz
         HEkA==
X-Forwarded-Encrypted: i=1; AKwUvBzu3ByvGmPtRZRMDMjZb52kcVeDgbulpL0DHN8sHiW+/SLv/ZL0JCoSXKs+RI4ha2Cjpt7RwbpDHVpLm2/x1De7@vger.kernel.org
X-Gm-Message-State: AFq9FYKfG11Fr97Le2ltQe3JNG8B/rXFKRFHs1aCYGIQMIHuRKj+orrr
	3yO7v+beODchrDR36ZAfa0sRxzwAfEM+3G+eeGzcYTzAuaQiNOcKt08y8vFaMcXw4Yo=
X-Gm-Gg: AYBFou0Hu1jSgjruPwmpQJ4CueLC5z9T43y8NcEXWGclgSbV26nQlgY2oQ8cd0qL+oL
	NQtL4o09xE62J5IzerOLLS06RD/JN4iVAmwlOFqwHq7jIyKI9qANpgHXkVlV9eRVlpIvwkq49cf
	JWBpqUu6mtt1KZpUfl9Yyr0U66PvrKFIGHh9nAJL3Hx5JMsyBcjjT9QtsLGJyzR9icc93st+V9w
	W1UfpqHg5kr/o5fFMMWJzIUKypGghjSHsLiB3htrxFKXMWHyyokKtbD4R6389NanPPASJ/h1rGX
	79yeV7YqwSyUCqvPdiq8apbKkiwFGv5mn+iuAo8FxC6B9OAYboN0lW2Nx9sHhtxVtBOR0FMnAoj
	B8mHYDclcEayHkwMdaJGk2Eql+eLOk1uVWzsxP/vJvQEjndGJTv8Z8tNcaapn223hEU6017uZ7j
	DKfHJ2IwSoeomrSFrNSfmeXB5+w6i8AcZDdhHXCSH6JUPkbc8BPNR/r6TqB27uXYspFdHky5GAF
	iG3gVN2eFuNU1YyU4c=
X-Received: by 2002:a05:6830:828f:b0:81d:c548:292f with SMTP id 46e09a7af769-830959380b5mr21128096a34.12.1792167479094;
        Fri, 16 Oct 2026 09:17:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a6f0a55csm2327426a34.25.2026.10.16.09.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 09:17:58 -0700 (PDT)
Message-ID: <93d5f73d-0126-4727-9014-836e195a3eac@linuxfoundation.org>
Date: Fri, 16 Oct 2026 10:17:54 -0600
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 5/7] tools: build kernel selftests in tools_build
To: Sasha Levin <sashal@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261016143143.3613501-1-sashal@kernel.org>
 <20261016143143.3613501-6-sashal@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261016143143.3613501-6-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/26 08:31, Sasha Levin wrote:
> Add a "Kernel selftests" sub-menu with one entry per selftests directory
> that builds with only a C library and does not write into the source
> tree. Each is built as "make kselftest-all" builds it, with KHDR_INCLUDES
> pointing at the UAPI headers installed in the object tree, but by its own
> make, so the selected ones build in parallel. Selftests whose Makefile
> does not use KHDR_INCLUDES still build against the C library's copy of
> the UAPI headers.
> 
> As with "make kselftest-all", a selftest that fails to build does not
> fail the build unless FORCE_TARGETS is set. kselftest_deps.sh then lists
> the libraries the selftest needs that the compiler cannot link with.
> 
> The selftests do not track header dependencies, so a selftest is built
> again from scratch when its own directory, a header or makefile any
> selftest may share, or the kernel sources and headers it includes (the
> vDSO test includes the architecture's vDSO code) are newer than its last
> build.
> 
> Selftests that need libraries beyond the C library, a vmlinux with BTF,
> or a sanitizer runtime are left out for now.
> 
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Thank you.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
