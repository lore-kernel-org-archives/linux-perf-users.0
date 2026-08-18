Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFE53246ED;
	Tue, 18 Aug 2026 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787088204; cv=none; b=sQFkfqt7eRE86MmBMJsJO46j/afIa+N2J3dwWxXdMOS9Lo5++t1h4IGGJrKS3KX2Mi08ZI9M4W1UkdzFxXuzM8BDq7LT6naZDhaNXhZgNu+yuJgW81uas8jejAR7NHr3v3KN8B3ADEvNCI3R+tX8qsW3uabUWhgxGWMUn9vXy58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787088204; c=relaxed/simple;
	bh=fzt2GVxp3M4MXrZxTZX/vv3lVLAdcrSwC3eGbtIUqnw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LJCOyd7SNnIVP0K0saNKZWKN7iPbeONN6NFWl1k5EZP438tOonJRgU0EY8M5PXOt7Ifd7mEp+soDcROoC9sr67zTwBlDofcP9dNCcZyFGYTXrxPqfxOdyBXqnLRBpPtj9qNeBVww7SObWqpXKQF94Tap/F6SiLBUpu97KYbvLeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8uz15/i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8uz15/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE881F000E9;
	Tue, 18 Aug 2026 21:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787088203;
	bh=ZZpeTmoB5TL9IdfJXgdv+svVQGkzRcLARzTOb+GMqrI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=B8uz15/igJJj6kXbU8EqvUdDXBatHpuabFY/yR+dKye+tpB0IHgJRztz71mMnNtlj
	 e2pl6L0z+dkSVgyBtw/knqFuuNdIot7MASp6nIf3trqnVeUigoEoqXD9eNzu3t96nC
	 5AKExJcgB/KmR2uwpjwisUIoMG1wWdFt5QGeo0D4JSGMn8zKQBGtk478BdlXKOTFOk
	 aGl8CGvRRSSx7Cv0rQgPaBwCdBFg2Fy6+1YYi0Nd6cC+s7e40aHZsjvdVh3WpKVc+v
	 0Lat6z6zIuihppwwfzcdHnzGf9P5uTgL+v8wjwCEzVavg40M179YZW/OfYlilATXH+
	 T+xlqJVLGGc8Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org, 
 adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
 irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, 
 mark.rutland@arm.com, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
 tianyou.li@intel.com, wangyang.guo@intel.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260817094623.3288456-1-jiebin.sun@intel.com>
References: <20260817094623.3288456-1-jiebin.sun@intel.com>
Subject: Re: [PATCH v9 0/9] perf c2c: add a function view
Message-Id: <178708820285.2068376.4445054053733143306.b4-ty@kernel.org>
Date: Tue, 18 Aug 2026 14:23:22 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 17 Aug 2026 17:46:14 +0800, Jiebin Sun wrote:
> The perf c2c cacheline view identifies hot shared lines, but it can be
> difficult to see which functions account for contention across those lines.
> This series adds a function-oriented view that groups the existing data as:
> 
>   read-side function -> contending writer -> shared cacheline
> 
> Pressing TAB switches between the cacheline and function views. Existing
> cacheline-view data and operations remain unchanged.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


