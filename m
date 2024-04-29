Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6338A1836E9
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427008; cv=none; b=WVoDwqYywZPMzZj/g58SuvIeNDq2/VoUhwi2zvSykpOQk5vmzbEtIYRTGuz8cEQxPyLtCwEZ83ZUmX+zka776y3+vLWRBeZlojD0VKC29GXpJHwF9i25bKBZ2TEkIjaLd0EPnqTG0sMmlAsFaYiCmmUUXHgZmcun5QNiaNnPpiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427008; c=relaxed/simple;
	bh=lBJpVuXa11ufxvAUsbruPF6r+nwd6t27g85ymKmCEfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqtQTFh9RNIhwOlx+R344sGi1+wy0Or0oIcWxZMof3BviMbPlDo6tXejShqrE8l447f7y/oliE+9rCS4Dh4C8d3U5oq7NzB/EYWKx+akB0K3MuHjWrb5WH8zM7ZBNpHB5TZnE81BYfHbnHNS4QIaKjAPQ2dzBkX/9U7+gdXgLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NpRvNMPr; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NpRvNMPr"
Date: Tue, 30 Apr 2024 05:43:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714427004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lX25l5/EcWcx21yRmKVKTDwDGn0IFOZUfn6ArjVrnnU=;
	b=NpRvNMPrea2EfmF2RwEIpB9C0Kt0d+B6Rctq5m+H8bbNQUYEz4/DZacaxE5ENSSrt+ud82
	C9bkmsoqEgC1EqucUjvGLz2PqKfrcaPH7qvHEl1lwwEUqp68SQEIbcRSaK9RFaSU1DUfxz
	jB/eAwwLLGBbETrHlBFoWm2I3lXf5fI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leo Yan <leo.yan@linux.dev>
To: "?????? (Baisheng Gao)" <baisheng.gao@unisoc.com>
Cc: "jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"???? (Hao_hao Wang)" <Hao_hao.Wang@unisoc.com>
Subject: Re: Question about using the perf c2c in UMA system
Message-ID: <20240429214321.GB125@debian-dev>
References: <80f723d230744bc299044cfd4f8c4d92@shmbx06.spreadtrum.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80f723d230744bc299044cfd4f8c4d92@shmbx06.spreadtrum.com>
X-Migadu-Flow: FLOW_OUT

Hi Baisheng,

On Mon, Apr 08, 2024 at 10:52:59AM +0000, ?????? (Baisheng Gao) wrote:
> Hi linux-perf-users,
> 
> My perf tool version is 6.6, and I compiled it to run on an Android system.
> The problem is:
> 
> # ./perf c2c report
> Failed setup nodes
> 
> According to the articles on the Internet, it seems that the perf c2c is only supported
> in NUMA system. However, the cache false sharing does not exist only in NUMA, and
> the UMA system has also the problem. So I wonder how to support perf c2c in UMA.

The log above is related with parsing NUMA nodes, but this doesn't
mean 'perf c2c' must run on NUMA system. My understanding is both
x86_64 (memory event) and Arm64 (SPE) support 'perf c2c' not only on
NUMA.

Thanks,
Leo
