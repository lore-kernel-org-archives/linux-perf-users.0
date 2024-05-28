Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CEB16D9B2;
	Tue, 28 May 2024 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910395; cv=none; b=MNB4nJW+jA+jDcufmPJTBI1nC4x7eAmvi6ihx9APtVXDIuF4r2r4HHc9gwauAw7vOBW8JkRh0xf32Cejw/E/ZmuZBnyn7V0XJG3sY4hTHRDZPlmZFt694VTGWsVDj3AEKL11E1nRNUME11PXXVwuebxEEBZ5j9EhFQF21AIe5Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910395; c=relaxed/simple;
	bh=LfKyNWX3NNA7HOkhNCbJcM+Xeojp5RxJ4j3pz88SCMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=uOH629xZ7mP9u3/EKjnUViO2lAmxWm5gmaAIpIQ3RsrrePGR7/Rgqn9K+B4YwxEkYvzI9aiOO9Y4fJG69BfBfCSSif7plvPEpNak/uJ5Yg7FqsNy24pwbIo64EDz/Ap5hYixyW6vqaGISESp1iXLUt2fCIgQAH9apRciZdxp+iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16DEB339;
	Tue, 28 May 2024 08:33:37 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 840483F762;
	Tue, 28 May 2024 08:33:11 -0700 (PDT)
Message-ID: <30bb744d-057a-443e-a35a-697995b3f314@arm.com>
Date: Tue, 28 May 2024 16:33:12 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] perf maps: Remove the replacement of kernel map
To: Leo Yan <leo.yan@arm.com>
References: <20240520090647.949371-1-leo.yan@arm.com>
 <20240520090647.949371-4-leo.yan@arm.com>
Content-Language: en-US
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240520090647.949371-4-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/05/2024 10:06, Leo Yan wrote:
> The kernel text map has been removed from the kernel maps by
> maps__remove_maps(), and the kcore maps are organized in order, allowing
> us to achieve neat kernel maps.
> 
> As a result, it is not necessary to replace the old kernel text map.
> Instead, the commit finds the latest text map, assigns it to
> 'machine->vmlinux_map', and releases the old map.
> 
> One concern is if a platform fails to find a kernel text map after
> updating maps list with kcore, in this case, it should not happen and
> reports the failure.
> 

Hi Leo,

For some reason this commit causes the symbol to not be resolved for
one kernel sample in a recording I have. It's a bit weird because the
same address is resolved in other samples.

  $ perf script

Before this commit:

  perf-exec ffff80008030cfd4 perf_event_exec+0x22c ([kernel.kallsyms])
  perf-exec ffff80008030cfd4 perf_event_exec+0x22c ([kernel.kallsyms])
  perf-exec ffff80008030cfd4 perf_event_exec+0x22c ([kernel.kallsyms])
  perf-exec ffff80008129a0f8 _raw_spin_unlock_irqrestore+0x48
    ([kernel.kallsyms])
  ls ffff80008012f5ec lock_acquire+0x74 ([kernel.kallsyms])

After:

  perf-exec ffff80008030cfd4 [unknown] ([kernel.kallsyms])
  perf-exec ffff80008030cfd4 perf_event_exec+0x22c ([kernel.kallsyms])
  perf-exec ffff80008030cfd4 perf_event_exec+0x22c ([kernel.kallsyms])
  perf-exec ffff80008129a0f8 _raw_spin_unlock_irqrestore+0x48
    ([kernel.kallsyms])
  ls ffff80008012f5ec lock_acquire+0x74 ([kernel.kallsyms])

James
