Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5297613A889
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302528; cv=none; b=P0vvnosqc6YWQzWJU0haPVp9/XieW/KTRvBsxlHQWXYepGEiavx4cwLP/vpw7jc7Lwgtb3pdYfasJYo5JkjXcj3F2tQHyiXj9ve1zioxaIOpJE04cfUPZGT33P78/2ZRefUthdBA3o/D0cuD70qkgBWJrO6gppeIgnL/Eji+WQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302528; c=relaxed/simple;
	bh=r7bht/QwMFmpzvd6GPCywPcatE5rm3mVxt2VDzLM0Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLaLsLJAvjMcnP+0d035yiuEtNeZ4t070zeQ9L8XrHkVI362M0AP9NzvAsXkkEp8a1F2WVm11bINVrvWlqHDceZ7WLx/jNOg2urPl9GC5Vd8Hhf+ukPX0cNrAPfbI/iHPxs/8UZIOjMYXUxHmYkBRPzjOthEc1EOzJdOd+KqHyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZ1iTpy5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZ1iTpy5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA6EC3277B;
	Tue, 16 Apr 2024 21:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713302527;
	bh=r7bht/QwMFmpzvd6GPCywPcatE5rm3mVxt2VDzLM0Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZ1iTpy58xRJJ6gDmLKXtXKE65cgoRymhgzydlER1d/Esf0EI2c971lb4Q8XACABc
	 d9nRx2OiCI0VfMONUlW+HtzEGbSWNx0qqBZ7X7nMcXzlX2s+r6Iiiey76U9j6JTaWs
	 7jEoSpfSJTFYxtiz9bfrmGeKKwkOmwIEi5fvRHDYQXM/wagfKbUMjUdzkKxHGblQAJ
	 36lpsIA9WahFxMVtZpPBcSoHDNANkTgnOEcSdhoxeWi2qYHpVBg5biZXPlJyl4SW4C
	 c8KpljQS9Bk8DJ+NS71zuMdJfIq2YtQDMz9UXzoYC7+/24WrEnnkrVJBz7c1XMB7Ds
	 uMt4OuCKK81iQ==
Date: Tue, 16 Apr 2024 18:22:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>,
	linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com,
	james.clark@arm.com
Subject: Re: [PATCH V2 8/8] perf test: Check output of the probe ... --funcs
 command
Message-ID: <Zh7r_CHY56sZO7KC@x1>
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
 <20240408062230.1949882-9-ChaitanyaS.Prakash@arm.com>
 <20240409080902.6f2ccd1239c64ca49861d6d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409080902.6f2ccd1239c64ca49861d6d6@kernel.org>

On Tue, Apr 09, 2024 at 08:09:02AM +0900, Masami Hiramatsu wrote:
> On Mon,  8 Apr 2024 11:52:30 +0530
> Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com> wrote:
> 
> > From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> > 
> > Test "perf probe of function from different CU" only checks if the perf
> > command has failed and doesn't test the --funcs output. In the issue
> > reported in the previous commit, the garbage output of the --funcs
> > command was being ignored by the test when it could have been caught.
> > 
> > An additional check to grep for "foo" has been added to test the --funcs
> > output.
> 
> Looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Cherry picked this one as well.

- Arnaldo
