Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A367A259C
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163042; cv=none; b=fV5j3PNMeJcf+5mNzw8jpsopkK5DtK/OQh0RMdmsXkbSx/XTY8dHSfe2YQc77wPzHL/KIvMi417+xMZN7IchhO7boTcS+tQPX3STY2RT7am9HCHqmFYdw2OGYM4N7wtODp/+Nn2QNauPIG5htaNzXtOITSE9njWqS1IDNnKhSZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163042; c=relaxed/simple;
	bh=GxpkkgQ5i94RaLgcgbEXEBtDGvTxCtYN2KduaWOSkFs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nCAW9Rr31i6KaKv8ieNWnEas8fI0F33Ymms481pi/Fxldf7Z3IHUKWgWI4vBbEw65UwoC6pSwz4Wv4eZV2qH7XXFzzS4Yo6W6KoMASlcRJem1+GobDX860uwEaP1l8q82b6vu6TnquM4GA/DSulEHDs0auQXjhibd+giXU9pyoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7353FEC;
	Thu, 17 Oct 2024 04:04:28 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC81A3F528;
	Thu, 17 Oct 2024 04:03:57 -0700 (PDT)
Message-ID: <3bd16144-0288-405e-85cd-05da2302ec5e@arm.com>
Date: Thu, 17 Oct 2024 12:03:56 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 1/2] Add map_pgoff to python dictionary
From: Leo Yan <leo.yan@arm.com>
To: Steve Clevenger <scclevenger@os.amperecomputing.com>,
 james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
 <c0ca69f04ba93f1d05d753a3adc28ad9a09d34fe.1728599785.git.scclevenger@os.amperecomputing.com>
 <32a15b07-9aab-456a-a484-e15309a4cdf7@arm.com>
Content-Language: en-US
In-Reply-To: <32a15b07-9aab-456a-a484-e15309a4cdf7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/17/24 11:43, Leo Yan wrote:
> Warning: EXTERNAL SENDER, use caution when opening links or attachments.
> 
> 
> On 10/11/24 18:17, Steve Clevenger wrote:>
>> Add map_pgoff parameter to python dictionary so it can be seen by the
>> python script.
>>
>> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
> 
> Sorry for late replying. LGTM:

For this patch, please consider to add prefix in subject:

   perf script python: Add map_pgoff to python dictionary

With this, please feel free to add my reviewed tag.
  
> Reviewed-by: Leo Yan <leo.yan@arm.com>


