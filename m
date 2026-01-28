Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D63382D6;
	Wed, 28 Jan 2026 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590806; cv=none; b=JvI7N97mXTfGUBwrlloK59RTWtPibyULbLVRZ/TZSpAFtOUQENAjfQ5EUVAdYIaKUWN3r1QZ7QLegcA+wyhIzeJn4lFKgKfSoA9HgFQALvVvfplBT28PgzMFARVIzXXAU4uQVCGajM/EBtaleYYU3i9HkVHPj+b4l4oPDYrgLwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590806; c=relaxed/simple;
	bh=crey8mIG8QmvtfanDANRbzsdoCQTckd9ZdZwYdVc/gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lj2NlrRVAawWmYKfvwPDrSFlH3pDL/utm0v+B3i1di374x3DH3d8YTOR4m0H3hfsCvMAvpMpvRPa7ZVZbbNl5OoLZB2jA09Ns8P/+YZ/haLanLXRj6LK+Wglr1I+gfhJ4XoRxGLbae49oe3PhDbRr/ZmLrXQ4z8fy1XgWYFVlxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p8cCxakM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p8cCxakM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=crey8mIG8QmvtfanDANRbzsdoCQTckd9ZdZwYdVc/gQ=; b=p8cCxakM3b3zuniN2dc+FBkWPl
	f5N9Xb3O3JrFmumiDGGmGz1Vjfji6mXkLzbv6jGBXZW0VQwNukpotBgVTnn58VzxqSOur3bcGqugq
	UX17sJegMhdaqnHgxJCyTTNEKm0wPqDEm8mLLWimNWPfpR5fp5iMGRzy/iyw9WCX6QdCyL+NYYBGS
	TJS1tuI2pZ7WyO5PCe8dopIWY+FJBh4gZZDF/2IrmR6z3gHpAKbIAX6Cj8BxwBgLMZgLdqJqYTtHk
	glgkytXC214Ezg6WgV1Eu9WTCUzZZnQiM7/yIQVbfRrwbSNCaw5bHh83DHlF8/RV5dwh0nW89Uw8O
	6aJPPKLA==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl1Ot-00000008BwG-10ou;
	Wed, 28 Jan 2026 08:59:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5B4E4300754; Wed, 28 Jan 2026 09:59:45 +0100 (CET)
Date: Wed, 28 Jan 2026 09:59:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tao Chen <chen.dylane@linux.dev>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 1/3] perf: Add rctx in perf_callchain_entry
Message-ID: <20260128085945.GF3372621@noisy.programming.kicks-ass.net>
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-2-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126074331.815684-2-chen.dylane@linux.dev>

On Mon, Jan 26, 2026 at 03:43:29PM +0800, Tao Chen wrote:
> Record rctx inside the perf_callchain_entry itself, when callers of
> get_callchain_entry no longer care about the assignment of rctx, and
> will be used in the next patch.

Sorry, what?

The recursion context is very much about the caller, and very much not
about the data. This just doesn't make sense.
