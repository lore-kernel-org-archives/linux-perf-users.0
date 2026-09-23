Received: from mail-ed2-f27.google.com (mail-ed2-f27.google.com [74.125.228.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E5B439913
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154919; cv=none; b=KfIk76dldsgO/b6ad31UXj2uo6ewCsOSPZfNUp7x/TTAEjtZ43wzekRgpWE0AtIPq8NvIeQrS1o9vxFrgF5laQx9/eqYDV3XgtteFOnwrJo07XfTkHmz5WXe3ExkbB7GwGkOuuCQkaoSgGTUhgZ/IaRY5TIl05czkzswUnTFIaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154919; c=relaxed/simple;
	bh=6D/QwhHbhAw48PLOUD1e/RlhNasr0vbYm/dASxiUKII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMCph3wysFHf2FZp5M0nTZB1y1tL64G2wEBo/7sb0Y0XN8R7yOPd67tA/bf6gH8pzMFq59HvjuTH+jsO9ZxjmX/8hLddBr99BIXrem5fj2Uq6KD88wy7k70XIZeEq+TdLcTusf+YTts8q2SqDi9BXdVqY7Gv9W5simuBbPInA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BlkRxNGo; arc=none smtp.client-ip=74.125.228.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BlkRxNGo"
Received: by mail-ed2-f27.google.com with SMTP id 4fb4d7f45d1cf-6aa135d6e97so1099492a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 02:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790154916; x=1790759716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eWPNdBRci+ilO56uoSaBVlNcIj5sRExNLvAX8TWjSSA=;
        b=BlkRxNGocPuvqXvgYW7acyFfDofjkraqMVpNErOzSs2TfPF8qig9oDgqx9aB94vQjP
         tdzZCIcHLGz1GGSzAPoj4MveHwe7REKAJ9YAn47eek+GbWwjNkF6q4oIkj/vGYpe9Kuz
         98xxjcsw0JyHWAZhWzipkTggBCy/BsdaSfewmYPwlYodyku6l9FpNWdk/YyYcoXvGYTQ
         PfuMq8R0AtqLpfm3WSb/F7fCUvA+YHjV9mNXRsNdbBcJnlTePfRCALY468vpd+Cv85w8
         xlj41NCld/QeV9EaPFsdquhL77Z1Y9TKDj7o63+EmgolHWvAHwR7qyf2WDEYOAyk+GO1
         KVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790154916; x=1790759716;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWPNdBRci+ilO56uoSaBVlNcIj5sRExNLvAX8TWjSSA=;
        b=BZXklZJHcMGVnFAmA7Ewtd/WPiwYm1Rv/ciPHnSD6v04UEo95J+yHNWH0QfQ3JTJhm
         3aLReoQMjfbVOxRtGxeUni5nt4PRemdFNF7Z8F7FfM9NTp9Okvh6SqZJF3yeS3srQv1Q
         8A3ALFBthyKHgtXHhjClNgqZi6Yy72tTflK3F5cx6aiiLxXJ8ZBddbrVEmMFbZ5bVYy7
         qIc9bFu1Swfe/nFaDC/qqaXijLPDHkpAOr3iIHg3rbj6smirPhq80baR1UoXOAsE7IOy
         XvD1N3K0Z0BURHc4SKAEJmOS6bjFNPtHooXrZF/WA8xjKEQtYiWXxOwikvHOZk2eoSIC
         ISXw==
X-Forwarded-Encrypted: i=1; AKwUvBwPph3VhKraiNVXdsrqYwaF32Aln7SXk+cTrBpGr1/yt9K1gYDybZgZd638a/kUumw6p7DJQZL0XeoxRBJDUf03@vger.kernel.org
X-Gm-Message-State: AFuF++l6EPRbJL5aplicYdR0RjsAuVSw9d0LjYjo27SDdrMxAFmfGRi6
	Ucvz36luTx689TZViTZ1cE831qJmreFbHamTz1FPDUwv1vza9etJowT9JTwvYLqNL6o=
X-Gm-Gg: AYBFou2x1QM+gaGANWCXi9F19MF4+t67SNL1sXsxaRMe4nFkSVwtvXn+jNFgNiMIro4
	38zSqScuHxoZGYRZo+H5I4DGHJ7r0Y+W0nkaoXmA8+Eizf2AYal5KQVZ3bFUOt/ygPQtg8SOaDt
	nLvY4JJ9IQ+to1FaRvq8KGz35dHL1UR3NxNo94wTMUwTXb8dPKgku6Am+h2pjYJDJp5bR+r6PGE
	0vhapl8D7w0saqLR4jiQqY2vwURTceYohh2zKu0kQM3MTdjCbr53+Tobg+wvdMRtnO9ODqISn8l
	3kmkdUX/iva5XQN2byJL/dsZQdSBkC+gnDFN3+qSAKyqUlDa8ZNUk49gsrmslM6kXDcb0S7jzl5
	Al78nJgHmud9zEFRm/T/FWWy+m29adYm+x9HffmiZCsnQZ8ye7V/V+3nY2yZnxavtJodfc9OFSY
	IUDGJTCWsSREyXIjzyR3e0L9+GHizV2ywW+rUfGaJz2l2GUv3wluvNRh6hazZn7qoOTpaDCEDf6
	KI=
X-Received: by 2002:a05:6402:4516:b0:6aa:734a:a082 with SMTP id 4fb4d7f45d1cf-6aab3b98705mr1736439a12.25.1790154916043;
        Wed, 23 Sep 2026 02:15:16 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab37478c9sm1181333a12.0.2026.09.23.02.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 02:15:15 -0700 (PDT)
Message-ID: <dfa8362e-0dad-4f23-9d2e-dde03cb5facc@linaro.org>
Date: Wed, 23 Sep 2026 10:15:13 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] arm64: Add BRBE support for
 bpf_get_branch_snapshot()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Leo Yan <leo.yan@arm.com>, Rob Herring <robh@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Shuah Khan <shuah@kernel.org>,
 Breno Leitao <leitao@debian.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Stephane Eranian <eranian@google.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Usama Arif
 <usama.arif@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260810164622.1829843-1-puranjay@kernel.org>
 <CANk7y0ixo5a3Vfzj_HVhVHRNce2Rsit4pP27GCtXd4jHHzmiKg@mail.gmail.com>
 <CAEf4BzapC=7YM2QLMyKKfyOWGgBTfEJmPPN8e9Jf5xT9SutBTQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAEf4BzapC=7YM2QLMyKKfyOWGgBTfEJmPPN8e9Jf5xT9SutBTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22/09/2026 21:40, Andrii Nakryiko wrote:
> On Tue, Sep 1, 2026 at 6:45 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
>>
>> Hi James,
>>
>> Can you review this version of the patchset? It is implementing what
>> we discussed in the thread on the last version.
>>
> 
> James, do you mind reviewing the patches again, seems like Puranjay
> went with the implementation you suggested, would be nice to review
> and ack, if it looks good to you.
> 
> Mark, Will, you guys seems to be designated as maintainers for
> drivers/perf/arm_brbe.c, can you please take a look and give your
> feedback as well? This is important and useful feature for newer arm64
> CPUs, it would be great to get access to this functionality that we
> had on x86-64 side for a long while now. Please help get this upstream
> or, if it's not in the right shape, guide Puranjay towards a better
> implementation. Thank you!
> 

LGTM, and the Sashiko review is good too. It does conflict with the 
FEAT_NMI patches on the list, and you'd have to disable NMIs but as it 
stands right now it's ok.

Reviewed-by: James Clark <james.clark@linaro.org>



