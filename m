Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8162619A28F;
	Wed,  7 Aug 2024 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723016982; cv=none; b=XHAkElmfXDrGhHQeZPHVgXM1Te5ODhm1GxBWNX+UpcEZAzg8m4veZTtFm/3In6+rO7rBBoK13zUJoKIB6HMXDKHENe5fzvGka/C+QwWtpXvCPWU39A/Lfq5+az7PCBrlIXNUwdYErF9Sq/BYcREeS8lP2Od1mOtc8wCZv5IfgyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723016982; c=relaxed/simple;
	bh=xtzBEPUnlgFGNGEjuqHM5K9gF2qygsYHtdBNqdgEi6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KTG2BPMNQE3R1jPrGd7OMY7wuwqR1TZIWn1wi5kk59iVHPwydZD9C29BN3R6GgQCBm2JVrtV5WxcUEcTtYVgTi+N8ski+5EbcfE+tXipKBJLDRPb/i8xmR/5moOmsgIVKMDkvn4mNw/u3j/vxENkzVGqkVKfWAtEY1yGTK0bbGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87B5A1063;
	Wed,  7 Aug 2024 00:50:05 -0700 (PDT)
Received: from [10.1.27.29] (unknown [10.1.27.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C7053F6A8;
	Wed,  7 Aug 2024 00:49:38 -0700 (PDT)
Message-ID: <b5688d4a-9389-4998-8031-3f002302311e@arm.com>
Date: Wed, 7 Aug 2024 08:49:42 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] perf: build: Minor fixes for build failures
To: Yang Jihong <yangjihong@bytedance.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240807032019.1828674-1-yangjihong@bytedance.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240807032019.1828674-1-yangjihong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/2024 4:20 AM, Yang Jihong wrote:
> Changes since v2:
>  - patch1: change LIBDW_VERSION to follow up the style of
>    LIBTRACEEVENT_VERSION. (by Leo's suggestion)
>  - patch2: Use a new line for the -ldl dependency and with comment,
>    synchronize tools/perf/Makefile.config. (by Leo's suggestion)
>  - patch3: include header files in alphabetical order,
>    add reviewed-by tag from Leo. (by Leo's suggestion)

For this series:

Reviewed-by: Leo Yan <leo.yan@arm.com>
