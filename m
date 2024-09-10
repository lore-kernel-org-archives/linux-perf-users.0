Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4055416A94F
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955418; cv=none; b=CiUBXSxQS1JZNRa5Q2kC6NK6gr3WcPLK760fLf5nrqypoN3oeo1vgcZceoZ2x5oRjPorFJenTnl/C2oPKhW3s6ACqtF6DhScqChSVkkzTQGuhrU0AtjemJMY/cYflRgBLhrICdYn4+nZaar9pgj/9xZfh+AavKo0HIozwMC0+sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955418; c=relaxed/simple;
	bh=/uKbLqzhVSyTQ2524k/X4gxtHN7ii6Hl36bsdMqPbYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xpfm956xFBrIRqWzew00R5l0lnEUIRHE/KJAExcoUpqGtGrYemyPDTdjsGAsGTPJtuCOPGohDXE2iw9yJH1z4D1Sj48i8I81rA92GQbOFVd0zE75zQWaYHi91M1TESYMG0YVLgwRr5EyWntfv2t5DDWvVxBGncVq4tsd+B7KvYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B965113E;
	Tue, 10 Sep 2024 01:04:03 -0700 (PDT)
Received: from [10.1.28.30] (unknown [10.1.28.30])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 483EC3F64C;
	Tue, 10 Sep 2024 01:03:33 -0700 (PDT)
Message-ID: <dbc41138-fdc2-42d8-9295-e2337010b470@arm.com>
Date: Tue, 10 Sep 2024 09:03:33 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 4/4] Adjust objdump start/end range per map pgoff
 parameter
To: Steve Clevenger <scclevenger@os.amperecomputing.com>,
 james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
 <6013572cde82955faf0d3a7ef7dcd415ce843c84.1725667397.git.scclevenger@os.amperecomputing.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <6013572cde82955faf0d3a7ef7dcd415ce843c84.1725667397.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/2024 10:29 PM, Steve Clevenger wrote:
> 
> Extract map_pgoff parameter from the dictionary, and adjust start/end
> range passed to objdump based on the value.
> 
> A zero start_addr is filtered to prevent output of dso address range
> check failures. This script repeatedly sees a zero value passed
> in for
>       start_addr = cpu_data[str(cpu) + 'addr']
> 
> These zero values are not a new problem. The start_addr/stop_addr warning
> clutters the instruction trace output, hence this change.
> 
> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>

Reviewed-by: Leo Yan <leo.yan@arm.com>
