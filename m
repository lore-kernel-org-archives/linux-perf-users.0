Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF143A1CF3
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 19:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777924364; cv=none; b=m+GNtj5rO6RkZq5uOsv5p4t7eP8Ehe6pyKRf3ZLd8Lkby4+t4kM33zvKdDcD3I2KXaTB18zC+wXF6mDyI0m8/KK4hxJLlYJ9qHQv+ljrqKT/AxJhcybCt82g0dymJDj2hRQkR1AO3u8BwwhPIGCbwkLJEdIkiF31hqEUKk5L1jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777924364; c=relaxed/simple;
	bh=LEy4a/kt7Cm33Haz282wh8z9T1PMXUkHfvsS7l3ikU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8lECMsOZAREhIxQjLF8HtFxJRMAfZKWM5b29RYq5YU6aq+6g0OwmF0PiHZ3uw+r6m7LK6+j35Zot4yD4D4aLIV6HBbl6P6bn2Rj4T+gDpHJ3RvAxYZFMsvQRW0u1fcHh4bMsyQO5OiyXFwx8hEmvx+7DYvxhSWQMq2vQiQcEvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=MjQI769D; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="MjQI769D"
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id JvaWwERWBrDqVJzJrwr7A4; Mon, 04 May 2026 19:51:07 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id JzJpwt58v2utbJzJqwWTii; Mon, 04 May 2026 19:51:06 +0000
X-Authority-Analysis: v=2.4 cv=K+IiHzWI c=1 sm=1 tr=0 ts=69f8f8aa
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=WsHKUha7AAAA:8 a=WtPqWeQF5UC7N-3dKWgA:9 a=QEXdDO2ut3YA:10
 a=H4LAKuo8djmI0KOkngUh:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BsyHKmKFoPpLbvqiWeXm/ob1Z52o7Jh/Wreo8Q7/3wM=; b=MjQI769DJeeIWqMJV41/UgaMXX
	8d3CwotB+cWLfxhelO+8qhLPO38MS+luPczwkwXHeX4dxKaBTsFWo/wK8mNx4pPuVns6mWCBpeAuq
	ewN+y7jwIu73czEi6KhOBF/Mr9sWkS01W1ZS6K62pPwMt4cUkgt0fhEBNHrjvF6XvEubOpCEY4gph
	Eiy3DxMDCkP3aK2+trHSDGgJAWkwxep1REjSewVnZ02/HnIpRG5oD9CYo6o4Z9NmBCOcZ899v09WY
	fyQYVQm/vFCXbbye4stbn5m70eOCcEBOh8+aF2Yer+z4DKKWQ8Tbj3n5FAD01j4BL+ybFKskJIDko
	rDSW0x7g==;
Received: from [177.238.18.176] (port=35438 helo=[192.168.0.36])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1wJzJi-00000000osC-1Dwe;
	Mon, 04 May 2026 14:50:58 -0500
Message-ID: <7aa0f09e-5d35-49e1-916b-7564d074df70@embeddedor.com>
Date: Mon, 4 May 2026 13:50:50 -0600
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] perf/x86: Avoid multiple
 -Wflex-array-member-not-at-end warnings
To: Peter Zijlstra <peterz@infradead.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <afJcDg1I5ZU5ZkXf@kspp>
 <20260504083228.GQ3126523@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260504083228.GQ3126523@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.18.176
X-Source-L: No
X-Exim-ID: 1wJzJi-00000000osC-1Dwe
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.36]) [177.238.18.176]:35438
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNdzXEir365qXV/qmvzON61s7yY7OiQHgvtw9SyqZAf9n5WmB4lyywRDz1a2UYiE/O8+DmKhTRErldX9vBvbIsOalg+ZWZiT3adDG1XSah+FA1+cw3Cj
 nuO7UHl+DevjbQYGfYrbJ8QfilHaNuqRopcXzD6AsUxPJDkncNQsvxeISOCvYhw6IXTyJnMDE0EuWJaA6JXi8AuyUD3qMumAei5J590xum10Dv43DwpHMOOZ

>    https://lore.kernel.org/all/20240806113254.GG12673@noisy.programming.kicks-ass.net/ 

Feel free to apply it.

