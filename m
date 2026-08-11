Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CE53E0732
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479238; cv=none; b=M3dGqsAXCBdNJD8IjtDcgeSbuXUOQ3IsmTGNJWwqu5DxTMAxxa4JvaLGLijPXzQUGEUt1wpbzkmvrWNf77vO08GYSNNkq3zZ45+k59ftc1FaqpXFM+T4V6VUeEnIHnTZ1x2NonUWiznawwtPVLpPh6lKyHy/1bh9cvmTeWcQliA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479238; c=relaxed/simple;
	bh=sGcOoZwaTWTmAxZFlW6sWeDFPJ35IPDylx/fIMfey48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+OiO/nz+mZEyyAS8hH5oHp1btpEROPxSSACPBDbWkQAotlja0cmLdvDMUXK+o9BOwgpffLA2GcRqD8Eqa3mRtvK2lxMLwM1eRRhfHoy1n7BVgJiXETosapthBo9zcGP2uMoHZAuvauqqlekf6CjPH+ccUoKQyz3FtU3Jv7y4R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V09dF9j6; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V09dF9j6"
Message-ID: <2b4e524a-cccc-47d1-9779-b40cc592e1cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786479224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f22bnD3Sko0dUdBxN3QNw/Z+ZrWPYkDLgjG8TY6rG1A=;
	b=V09dF9j65JUlhfcjqaeq+VmWdpAzRmYHvvnlHqtx5/gzL2DcKqZ8O3MWGueU3AWU/3RSIj
	hM5rLo+hyvUaSDcHIEnmoyJaShGLUjC88DMANkg259S5DiuN5FNIsIjNP8q8uOV75JZ1Ke
	qJ3l/Yzr0pn30dekDUOHDzpxvqzZNQs=
Date: Tue, 11 Aug 2026 13:13:37 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9 00/20] Add Counter delegation ISA extension support
To: Paul Walmsley <pjw@kernel.org>
Cc: Will Deacon <will@kernel.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Anup Patel <anup@brainfault.org>,
 Ian Rogers <irogers@google.com>, Rob Herring <robh@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org
References: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
 <42cea3ec-5f9d-7f47-bb8c-ab2789246918@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <42cea3ec-5f9d-7f47-bb8c-ab2789246918@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/8/26 10:36 AM, Paul Walmsley wrote:
> On Fri, 7 Aug 2026, Atish Patra wrote:
>
>> This series adds the counter delegation extension support. It is based on
>> very early PoC work done by Kevin Xue and mostly rewritten after that.
>> The counter delegation ISA extension(Smcdeleg/Ssccfg) actually depends
>> on multiple ISA extensions.
> I'll put the first ten patches in riscv/for-next, replacing the ones I
> queued up earlier.  Let's take a look at the remaining patches in the v7.4
Thanks!
> time period, due to the other recent updates.
Sounds good to me.
>
> thanks
>
> - Paul
