Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B9F18132A;
	Wed, 29 May 2024 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997172; cv=none; b=ovilWO2Czph5XuK6/L94TY8kI4+/9XbqrBJbs/hjSylJc+pzAxvOs8wN3HB9WALpu8Dqy/K1xa6KyZxvOH9Wg85Z0zEPHx0hcOhv53MrMSJ6jG60oHjH463EChK55hhN6jPA/vb0zi6eWCjgtmcD4ftg1Zj7kkI1TiuQKQdNyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997172; c=relaxed/simple;
	bh=TliaClem/BlBEA7n1ndUxu2dBztOR2NCv37zhVcHmNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=VBj8oLVah0DMYQgXibSQzF8gLVx3ZKEahHWYZmInKYLWfFJDTV25H9TCajnrcchnakb9Qpn+gK8AiyS1XFziDAjEE/SIMVdrRfwPWJDn59qSkUQGpDv0JbS+sWSN4klzFkXZdhzYFNn8ttTMD8Za3wQkrJxhrp1hjUCYJyIugww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51C98339;
	Wed, 29 May 2024 08:39:52 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B50063F762;
	Wed, 29 May 2024 08:39:25 -0700 (PDT)
Message-ID: <35d6875b-9a28-4953-a187-b6659880ac66@arm.com>
Date: Wed, 29 May 2024 16:39:27 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] perf stat: Remove evlist__add_default_attrs use
 strings
To: Ian Rogers <irogers@google.com>
References: <20240510053705.2462258-1-irogers@google.com>
 <20240510053705.2462258-4-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria
 <ravi.bangoria@amd.com>, Yang Jihong <yangjihong@bytedance.com>,
 Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>,
 Song Liu <song@kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Kaige Ye <ye@kaige.org>, Yicong Yang <yangyicong@hisilicon.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240510053705.2462258-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/05/2024 06:37, Ian Rogers wrote:
> add_default_atttributes would add evsels by having pre-created
> perf_event_attr, however, this needed fixing for hybrid as the
> extended PMU type was necessary for each core PMU. The logic for this
> was in an arch specific x86 function and wasn't present for ARM,
> meaning that default events weren't being opened on all PMUs on
> ARM. Change the creation of the default events to use parse_events and
> strings as that will open the events on all PMUs.
> 
> Rather than try to detect events on PMUs before parsing, parse the
> event but skip its output in stat-display.
> 
> The previous order of hardware events was: cycles,
> stalled-cycles-frontend, stalled-cycles-backend, instructions. As
> instructions is a more fundamental concept the order is changed to:
> instructions, cycles, stalled-cycles-frontend, stalled-cycles-backend.
> 
> Closes: https://lore.kernel.org/lkml/CAP-5=fVABSBZnsmtRn1uF-k-G1GWM-L5SgiinhPTfHbQsKXb_g@mail.gmail.com/

Taking a look at this one now. I think some example commands and outputs
in the commit message would be helpful because there are quite a few
different things mentioned in the closes link.

But I'm assuming this is just for the command without specifying an event:

  $ perf stat

I didn't realise that wasn't working properly and I'd missed that Mark
spotted it in that link.
