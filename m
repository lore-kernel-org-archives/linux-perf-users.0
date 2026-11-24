Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527843;
	b=2AM/PvVf2PyevM0zhLU70JqI5kwXyzKQ9syRq5CxlbzA6lcvyIiYv+5iT7MGoibrRBXD
	 O+pqETfwlo4SG9Qr2nf9h2eNZgDcThJoyJgCLkGd6Rr8g2VNc074CZCSWLs6baP8CiVh3
	 szuIoc44cJLebriILUbT+imwM/1DUL2JJ//cWZPvAO2zQLJ02FDCvPUehTjIqgV2G0cAc
	 tR324ebQOwvJaOmpw5TtwXGSBjAAIxQdkEDwJrvqbTXUpLOzF0tTINb7IUWo7dEdCNCby
	 Q0PUEE4Ni95j/iaDVIVAPclOX9hV2frWB+1FmzzoVf5+XvDWoMQu4IOISikHonO2pxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=HL+5caFaLNCm0Bzmeli0hxBV4yqLWLj+qSToddXa65o=;
	b=QpYfMUIdIXjmN11mBNqEl6alKbRAt33EDtM4pJoS4C1xsRg62BwIdequm3QILoXwCxMH
	 l7SK5EcWWkAgXT4CC+HwW0bh9fgUjh92+rtbkfy9rV1Gf2lWSUsfGqVeB9bK1LrbFCGSp
	 OCsIvoHkbA/R0mIOHD1pl/RzAH5EvGCkNg75YqnVeGMaXCPV4cyyI/ySFp23aMZ9NZqTu
	 4ysJHsU/gIxklnMwkd8BAli5TWz/5dZBWuCiNCW9MLttMF6mysDy+hn0bnS794o9rNS9B
	 FZYTYL4mbordbuTaGcuygzqwDOJw4hKoylUbGOKSjEaSROPfieiPNUL0lSpbu4LYmpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UrutW7Jm;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B256606A32D
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 13:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B256606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UrutW7Jm
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so7672570a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 05:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795527841; x=1796132641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HL+5caFaLNCm0Bzmeli0hxBV4yqLWLj+qSToddXa65o=;
        b=UrutW7Jm73su+ht5qlo/MmxHxQTKsyjcHIgWSCzlvLi8qbFUiDmGfUustyKTYAvH6N
         ZoXu7YO4EKYZb/zJVjT5XXlbN3XlAqux+XXPOU4Taf/EPdF2N3XvTVEQ4PBQXqdmEJ6Y
         kqpWDVmwu2IteHmJ2niepLG+Tfl5THcdueQh1Ndo3u61takJHn5nrTfFtGH7gSb3fYXA
         xk4lXtchZ54mU/727M0lb7bXQXiGx1UHgprF4j7iK5wsU4/22SUuW7wA8Z7WoqwQdSBs
         at3WDG3L/1kRPzbBRC+bLOEtRvj0m0Hc6sYohHvE0Jni8K5M0tvh+5aZMHsra8HsNEGB
         tQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795527841; x=1796132641;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HL+5caFaLNCm0Bzmeli0hxBV4yqLWLj+qSToddXa65o=;
        b=hCLwxcLtuAB/elMOLYtYuppTnH70HoIBk5lTi5mTj88k3FdZk5Wfw/x18QoDdG8iFV
         z0dFr69JA8Rpr5brv3j7NkgC18o9hmN3FTGXJSD03B2ZLS1fqJOo+U2IQS7pn9mfBel2
         bW+41xuJOozW2CC4HtSgL+JpaBbBxItNKOXvzv2IOLa9Fm1BTW/KoCu7lKw4fYfkTAAk
         46hlDkT9gKFLTd7tmQHoy5ik00D37ogXLxHlRO4CXQz63Nl8Z9sn26Fi2wAEJybMBa7u
         gA/Rz2JCs079MWMN+tu7S8l/FeCh/iBfJBIfhg2kgj4XY4+7Ltgxc0NqWM2+dnbpqwic
         Za1g==
X-Gm-Message-State: APuU4Z9dO1aH8OaI0VtKIz+PY4fIOgBfYaYT/ehYD4NAQEAgkqhgtht7
	9B5q3xvEMJ3OPb5NeZBC4pN+FBqNR5xdJqQq/u9sv4Xpd6YLEG/fllWH5JpQG/6SZGU=
X-Gm-Gg: AZFdTZeKlA20Ebbki44QmBT07VpLrapR5Dl5LaMePL8p+rq9vGRfpzX2hGnHhU4wUNQ
	k0kfYLh5JJjr9eAur8v+fw/6bm+/12i9xg/S84QPDqO+9fW9nctNtt4PtBEFWoIdnh1bheBrpSb
	zi9dDXzjeteG0Vjdt87cufKERI1xoafDzyuVf14jHrwquOGDVO9reI1f6VgNEoUgDb9oRAb9FPJ
	m4vSi0CZig+6LlEW6YJ1mk1C1eKa/1faQidFRfFmanLR/1MtUiakPZYvqLD/NyzbXSmxezDJ+ew
	10Rig/fG2E0RgT7MQL+8E+7qDpAt19f1vq6iWGuBNQoy7kKymTs0KFfTQSMZVY1vqQIpgER3Z3R
	7EkXmK/P7BUnXMvlWTjfwGRgD2nDp8Xh3m99IbsW9CBTrWTE5XyQD+0DB0y/qQ734oNzfUPqoBv
	CugdPpe0AzL0X9nYZ7NpJl6J79Df83DGzl41kX6/KYoN46HWQIfycivnUSAxfcFmVvu2hHC7J2J
	bG1GTfkW2JkqnB0xeAK13otGyRnETwkEmwt+p99PJ8ZIM7lRzJaz73GBiBqw0rayg4uwRx81gxX
	1aVpvCH1BbITTDR78uDE4fQ3/S6HmHPk7A==
X-Received: by 2002:a05:6402:3207:b0:6b5:8222:cd12 with SMTP id 4fb4d7f45d1cf-6ba37eb3c1dmr11223007a12.37.1795527841554;
        Tue, 24 Nov 2026 05:44:01 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba6f8fa5b9sm5396452a12.37.2026.11.24.05.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 05:44:01 -0800 (PST)
Message-ID: <ceaea0f9-6f17-4626-bd55-fbc7366905ce@linaro.org>
Date: Tue, 24 Nov 2026 13:43:59 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf build: Only enable context analysis with Clang 23 or
 later
To: Arnaldo Melo <arnaldo.melo@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>
References: <20261123-james-perf-late-parse-attr-v1-1-cfebcd81a962@linaro.org>
 <CAP-5=fXuQWTt1F6BvKSXqgSkEtBQPKvKg6gmAe-ngyr4VGyGig@mail.gmail.com>
 <EC27692D-9692-4976-B7EA-4C3A91173CE3@gmail.com>
 <awSu48pUIh942Zm4@google.com>
 <46a896ba-cd45-4747-837d-50ea4b4dbed9@linaro.org>
 <0E9F372C-C100-41EC-B5B3-46FEDC813E01@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <0E9F372C-C100-41EC-B5B3-46FEDC813E01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/11/2026 13:08, Arnaldo Melo wrote:
> 
> 
> On November 24, 2026 8:24:37 AM GMT-03:00, James Clark <james.clark@linaro.org> wrote:
> 
>> Looks like __guarded_by() has also been around since at least clang 18, so that wasn't the issue. The problem is that it's not supported on struct _members_ specifically until clang 19.
> 
>> I sent another version that stubs it out for < 19 which works. The commit summary changed to "perf build: Stub out __guarded_by() on older Clang versions".
> 
>> The header diverges from the kernel one which isn't great, but I suppose that's better
> 
> Right, but you changed how check-headers.sh treats it to cope with the difference and I'll make sure that tools/perf/scripts/sync-headers.sh handles this case as well, namely if check-headers.sh detects drift, sync-headers.sh will update the tools copy while keeping the tools specific parts.
> 
> acme@number:~/git/perf-tools-next$ make -C tools/perf help | grep headers
>    check-headers         - check which header copies are out of sync with the kernel
>    sync-headers          - sync those header copies with the kernel, creating commits
> acme@number:~/git/perf-tools-next$ tools/perf/scripts/sync-headers.sh --helpUsage: sync-headers.sh [OPTIONS]
> 
> Sync tools/ header copies with the kernel sources and create commits.
> 
> Options:
>    -n, --dry-run       Show what would be done without making changes
>    -N, --no-build      Skip the perf build verification step
>    -C, --no-commit     Copy files but do not create git commits
>    -f, --filter PAT    Only process headers matching PAT (substring match
>                        against the kernel-side path)
>    -F, --force         Sync also when both copies have content the other
>                        lacks, after manual investigation; tools/ additions
>                        dropped are recorded in the commit
>    -o, --output DIR    Build output directory (default: /tmp/build/perf-tools-1000)
>    -v, --verbose       Show more details
>    -h, --help          Show this help
> 
> Environment:
>    SIGN_OFF_NAME       Override git user.name for Signed-off-by
>    SIGN_OFF_EMAIL      Override git user.email for Signed-off-by
>    OUTPUT_DIR          Build output directory
> 
> Through make:
>    SYNC_HEADERS_ARGS   Options to pass to this script, e.g.:
>                        make -C tools/perf sync-headers SYNC_HEADERS_ARGS='-n'
> 
> The script:
>    1. Runs 'make -C tools/perf check-headers' to find stale copies.
>    2. For each stale header, identifies the kernel commits that changed it,
>       including the merges that brought content of their own.
>    3. Copies the kernel header into the tools/ tree, skipping it when only
>       the tools/ copy changed (it is ahead) or when it carries intentional
>       edits, and stopping for manual investigation when both sides have
>       content the other lacks.
>    4. For beauty headers, runs the relevant beauty script(s) before and
>       after, showing new/changed string table entries.
>    5. Builds perf and the other consumers of the header to verify nothing
>       breaks.
>    6. Creates a git commit per header (or group) with the standard commit
>       message format.
> 
> acme@number:~/git/perf-tools-next$
> 
> I.e. the limitation in point number three, about intentional edits, needs to be lifted.
> 
> - Arnaldo

Oh nice I hadn't noticed sync-headers.sh. What's the plan to support 
tools side edits? Something like exporting the kernel change as a patch 
and trying to apply it on top of the tools copy? Or I suppose you could 
do it the other way around and try to apply the tools diff on top of a 
new clean kernel copy.

> 
>> than someone on clang 17 or 18 missing out on all of the lock analysis.
> 
> Right.
> 
> - Arnaldo

