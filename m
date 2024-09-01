Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37811E50B
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Sep 2024 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725198828; cv=none; b=GAAXYXET7AYhLkmGMmN+tcF17JvzcnRfphI15r5ymOiDhU2qa9WMK9uOYjEi6MvzvHFo9gH6hkVHVg6mvIP9EhIquMVnY17fIA4yGT67VLeeBkXeyde8b0Ju6UqNvaoD+3R8J6YYj8w9Au1PRHanTpPqHiSsJ5fSZAFzk+YieEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725198828; c=relaxed/simple;
	bh=22so55yO1J4X/TmkYVFJwCKz2L20OlEtzb6p0lcohSE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hsnSB91RU7XvXi9wo8nwgV0Bnju6dc9mYyL7eiEoZ8QZrmBZ4guWIA4PW/Pq7/kJp5kloGWjsNWsD2a4Zo23gx7FsdzCECS/AYFhXGVtBfmm/gI87K2mxGzoTDpDEWYJVtgbvNyWJrjzoonJSiak2YobEjhgXo22AqcbIxswuhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D5F1FEC;
	Sun,  1 Sep 2024 06:54:05 -0700 (PDT)
Received: from [10.57.81.125] (unknown [10.57.81.125])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D7843F73F;
	Sun,  1 Sep 2024 06:53:37 -0700 (PDT)
Message-ID: <8e6ecb00-81fa-4e24-92cb-de2120034309@arm.com>
Date: Sun, 1 Sep 2024 14:53:29 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH V5 0/4] arm-cs-trace-disasm.py/perf must accommodate
 non-zero DSO text offset
To: scclevenger@os.amperecomputing.com,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1724879699.git.scclevenger@os.amperecomputing.com>
 <cover.1724879699.git.scclevenger@os.amperecomputing.com>
 <35c19a0f-580a-4d97-b0d4-b8708a4dbdb4@arm.com>
 <01419593-056b-41e9-a3d2-6ac490f7734a@os.amperecomputing.com>
 <9822c444-69d6-436d-b1dd-6d9c910678ee@arm.com>
 <7a2c53c0-0bac-4a53-824d-6efdff8ed3ce@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <7a2c53c0-0bac-4a53-824d-6efdff8ed3ce@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Steve,

On 8/31/2024 8:19 PM, Steve Clevenger wrote:

[...]

> Hi Leo,
> 
> That's great. Unfortuantely, I need to submit a V6 for patch 4/4, which
> is the arm-cs-trace-disasm.py script. Kernel instruction trace requires
> zeroing map_pgoff. perf makes most offset decisions, but this one is in
> the script. It's a one liner.

Agreed the kernel symbols should be zero map offset. 

Thanks for correcting this.

> I know you're a b4 fan, but I've never used it. If I'm able to make
> progress with it I'll use it to resubmit. Otherwise more of the same.

For using the b4 command:

$ b4 am <Message-ID>

You can find the message ID in the lore webpage, e.g. for this series,
in the cover letter link [1], click the 'raw' hyper link, then you can
fine the Message ID is:
cover.1724879699.git.scclevenger@os.amperecomputing.com

Run 'b4 am cover.1724879699.git.scclevenger@os.amperecomputing.com' for
downloading the patches (with automatic amending ACK and review tags).

As result, you will get the file:
v5_20240828_scclevenger_arm_cs_trace_disasm_py_perf_must_accommodate_non_zero_dso_text_offset.mbx

$ git am v5_20240828_scclevenger_arm_cs_trace_disasm_py_perf_must_accommodate_non_zero_dso_text_offset.mbx

Alternatively, if you are using new b4 version, you can directly use
the command 'b4 shazam <Message-ID>' for downloading series and applying
it on your local branch in one go.

I tried the b4 command for your series but failed, I can see you used `git
send-email` but the series was not discontinuous so b4 command cannot fetch
the whole series.

You can just work on you existed patches - don't forget to append my review
tags for patches 01 ~ 03. For the patch 04, after you send out I will review
it.

Thanks,
Leo    
  
[1] https://lore.kernel.org/linux-perf-users/7a2c53c0-0bac-4a53-824d-6efdff8ed3ce@os.amperecomputing.com/T/#mc76180d8076cf3414ba81e7c379cda93297aa4a9
