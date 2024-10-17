Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF551D7999
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729204008; cv=none; b=PpCy798cnLD+cLP98gxqOnGy+3YOmIDKaZlofryqj+iOZbjkJtDRfyYbOLdgLd4r5S7FUAT8xFb6pZviXaaI32okKSGYGH0o4pj4JDHj1evnJGYDwSUPyl2DkMjlWNnCh192UgvDHmpAc2TyEoP2WwD0C3Ye/KhXgGyT9L3BE0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729204008; c=relaxed/simple;
	bh=pkiwBijR7TpuinWp7aOA8igGuhlYLhkL0iClX2b6/sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKwQTZKR6jqbjPP1BBIlaTZRKn10WsELWtTUaVB95wL7jwOghs5igS7oRFGDOfc2z6RrZZaTyKJsM8M90Z0PW3gAy7FMmwoNHFsHmyJPfj09MzwX2/f8iVYAmu4SKMIbLtFpo02WxzSx6nBsRnGy1tmZqByQH9vZmT5HprmGxq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBqmXAk3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBqmXAk3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE945C4CEC7;
	Thu, 17 Oct 2024 22:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729204007;
	bh=pkiwBijR7TpuinWp7aOA8igGuhlYLhkL0iClX2b6/sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uBqmXAk3hFI6SeZk9RDZWpgljKTFZ/Nz+6WjaQcIVIzeJFL8zZmUds8JaQBEvPD9A
	 g9e4PgGiERn6nSRzt5MnJnzOzSK2BIznOrx1tr8XQnEFWxJB8qLCpc/aXgHP3+9XsO
	 h+TbNyLwtAAzNBljRe9BYK0lQqWSWwYCgcrUqF5T59wcmhvcbDwuyHUV4kPhKSE/lq
	 i5XrVFKO2seErNBFyTVRGT76M5Iwsq4rhWw1r2J1Z7cr37bkygnl6fZR/jk5prnXvG
	 HM3Hrs3z7fw3Olv0mli3Y5lnx81VPHeuC5SygM8EZ3tGjKep2XtjTI98m5ho/wGEck
	 nTB0PikKc4UtQ==
Date: Thu, 17 Oct 2024 15:26:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Fengkai Sun <qcloud1014@gmail.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: Toggle perf stat on/off periodically and keep each sample
Message-ID: <ZxGPJpbElYMQhQDX@google.com>
References: <CAF6YOcNRt1=Dgw85QtVgwOY1QYTOd9E=V4Vr9xY2cjZp5n+bgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF6YOcNRt1=Dgw85QtVgwOY1QYTOd9E=V4Vr9xY2cjZp5n+bgw@mail.gmail.com>

Hello,

On Wed, Oct 16, 2024 at 09:28:33AM +0800, Fengkai Sun wrote:
> Hi all,
> 
> I've been using control fd and delay=-1 to toggle perf stat on until a
> certain point of the program, and it works like a charm.
> 
> Now, I want to do this periodically and keep all the results.
> Specifically, I have a performance-critical network program that reads
> the packets in batches and processes them, and I want to record the
> hardware counters on each batch, for future comparison.
> 
> Intuitively, this requires two functionalities I have no idea how to achieve:
> 
> 1. The ability to zero out all recorded counters when the current
> sample is finished and
> 2. The ability to keep individual samples, instead of outputting a
> single overall result when the process finishes.
> 
> I'm wondering if this can be achieved under current version of perf,
> and if such recording makes sense (e.g., does not incur too much
> overhead). Thank you!

I think you are looking for something like interval mode like -I 1000.

  $ sudo perf stat -a -I 1000 -e cycles,instructions sleep 5
  #           time             counts unit events
       1.001064439        644,313,943      cycles                                                                
       1.001064439        548,175,426      instructions                     #    0.85  insn per cycle            
       2.002682133        570,454,723      cycles                                                                
       2.002682133        426,891,566      instructions                     #    0.75  insn per cycle            
       3.004412672        565,162,161      cycles                                                                
       3.004412672        351,875,655      instructions                     #    0.62  insn per cycle            
       4.006131920        463,748,461      cycles                                                                
       4.006131920        239,702,866      instructions                     #    0.52  insn per cycle            
       5.001878221        466,409,911      cycles                                                                
       5.001878221        235,684,130      instructions                     #    0.51  insn per cycle

Of course it doesn't turn the events on and off.  But is it something
similar to what you want?

Thanks,
Namhyung

