Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325D55477E
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jun 2026 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781878782; cv=none; b=CZo5FZuE9lusLd0rPw3sQb0MO2vNUH9RryE74LfAcxGWd0GshGjoxjfjgcnZ+35ye3P7CipPDNHpaVFIr8tmlycvqdQuikVJaS3oZ7c7OLEii1ajhfGWrHcTj4U++AFE5qROexVFFD1A4svZw+0mFF/8NgdUZ2krVE0c2qaq/yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781878782; c=relaxed/simple;
	bh=sFNSm1vHjaSYPETXq5f+kuGVb6u7hVkeXTFmQPyJCGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMoOjc+aJPUObecO2WK8TNIKk26IpxuUo8HsC/hTMctq4NR6WNBUNVRCavZ7wONdoaljy2XWfjTYatphWLvDTfhwyhqdPNuV+7qxEvRC9i23L7ODQXj4O8zqXAxorAqQDdwQ9qE1q/OUSNrithbUNslUHIig7RXYxxl13WrprO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=nh+r8yz8; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="nh+r8yz8"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 48800D18E6;
	Fri, 19 Jun 2026 14:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1781878778;
	bh=mmRDmQPqulLx0n/oUizzXy3YJG2yV7aFgBo30NH5G7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nh+r8yz89HynpCeZWimaoNB2cha/Tq91d+kchQEqClwiFdk4mwiH24aj0OlJZfl0W
	 CN4eERNvugwlpuErTCD1BrLVDQ7MZbbhdPZzssa4XkP7+svxtSxGf1XTQHIDFBCp6K
	 m40YSDjagv1HFvJKvgF2+7PTlbCmGSid0V2z2Pxk=
Date: Fri, 19 Jun 2026 14:19:32 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/3] perf record: Avoid overrunning the zstd output buffer
Message-ID: <ajVP9GNJIKC3sAHC@shell.ilvokhin.com>
References: <cover.1781797544.git.d@ilvokhin.com>
 <7860259ac13e539dfb907489be29d0487d36aeb8.1781797544.git.d@ilvokhin.com>
 <20260618162059.8B59B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618162059.8B59B1F000E9@smtp.kernel.org>

On Thu, Jun 18, 2026 at 04:20:59PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Does this check introduce an overly strict requirement that causes compression 
> to fail prematurely?
> 
> By requiring dst_size < hdr_size + max_record_size + sizeof(u64), this 
> condition unconditionally fails compression if the remaining buffer is less 
> than the maximum record size (typically ~64KB).

Fair point.

After thinking about it a bit more, there is also another problem: the
check is bypassed for the first iteration of the loop. I think it is
correct, because of how the output buffer is sized, but it is not
immediately obvious from the code and needs to be traced through few
call levels.

Probably a better solution would be to have 'header_size' argument in
zstd_compress_stream_to_records(): then we would not need to rely on
process_header()'s return value, the check could run on every iteration,
and it would only need room for a header rather than a full
'max_record_size'.
