Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D80A2DE707;
	Tue, 16 Sep 2025 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050750; cv=none; b=jhX5zh+8VRpKSOJZoxsU28v7iUWW8elRTA/9/vEV7McfiPjnMza6j06vpM0ynRe1lrwq6qF20otS/tB3V6IYaArY1syksAeV3RhY2N+dWprDmV63Odkc+ytcTbRcdhBTDHDRtmB4UButJm8BsWJgKkCyBwPLhF6aO/WMAa7ntzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050750; c=relaxed/simple;
	bh=NTM9phhJY7tFV6Vjfe56zXmMyjIemIO8RQM+Y4MM7XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWAL+TVvtqt02KjNrsE3OYj1TEiB1ZuUD/HrmUX3ysDJuhCq/eElrCoHIvbhTQ+6SUJPP7waMGK7Rd/uhjfpm5RkOPCqrrQ79/UEjtGZ6kNSMoSXBpO4kfolqtDS2Tgvd/kC9IAY9LjUnP4Y9JjORTt4H7hKiJMAFUDl3XPr5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSVn5u9r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSVn5u9r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796A5C4CEEB;
	Tue, 16 Sep 2025 19:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758050750;
	bh=NTM9phhJY7tFV6Vjfe56zXmMyjIemIO8RQM+Y4MM7XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSVn5u9rn0rJ4dXhcoSQe9+sq0JVi35m3M0LkdJaDU3LR4JULS0HL9afq5XMrAz+F
	 TyWMv6/RGw0CyRKIM1pjCRAb4n+Gw0eR/h3DrZxvJsxS5kBBOzGxWdJRWSl1bsDXSD
	 wtJZm+r7CCzsYK3lFfidr475oHr0ElgDH6C9cBsqH8HK0+ek0/qaW1Z12bJWuuHScL
	 RwPSx0mPhP02Q8NdCCyeJ2XpdEzcfGcFPlLSZo5gEsYGVzo4aIYfcEP/1OMgvd9EK/
	 n9H8jfsDFR9ww5+xjeieWp/ckouoGze75ukSXeWVrQDx1FoYAq3pIJoMTF1wkkevsM
	 teJXtyI/Pskdw==
Date: Tue, 16 Sep 2025 16:25:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, maddy@linux.ibm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf python: Add an example for sampling
Message-ID: <aMm5uvPsMfXEv8Oo@x1>
References: <20250728055937.58531-1-gautam@linux.ibm.com>
 <aMlmiHATn5WHUcSM@mac.in.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMlmiHATn5WHUcSM@mac.in.ibm.com>

On Tue, Sep 16, 2025 at 07:00:48PM +0530, Gautam Menghani wrote:
> Hi Ian/Arnaldo,
> 
> Can you please review this series and let me know if any changes are
> needed?

Looking at it now, sry for the delay,

- Arnaldo
