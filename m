Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90F23064A3;
	Fri, 21 Nov 2025 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763755381; cv=none; b=KAc2Q5t3tTRcokbQxXjL0FkdAH8K4xAH7rzh4LuAaSMLKZOlTENg4a8QiLQV4BaTDbT/oD4zuY+RRgac53SLuJ0hlwvtlRkxiCP4u6Xf74MIr29joAHPDG5lQB1cZNz8h1X7j8xFdofA7uTcAn/Lq5hOKIncNEjhz/TrmhniqlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763755381; c=relaxed/simple;
	bh=4OqO/ugxuEMRtH3V+VD/oAkIwrAvfovYOwp2JomIRDY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HPWjzsL/Fe6o305xyGG256yRPuQAXZnl696HH33Zywmcccx0G9j5pEbA2vuneeYu0XqAvG2YsMvEkzpa+Y7tW/oC6fXcT+TQAdR4JWl2u84WvtV0R40CqKeBIcEEN6itt65k6TkVXfWkU37lLEj47o0XgWBVqWBXW1iej2HzO7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jpz81HGT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jpz81HGT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EE9C16AAE;
	Fri, 21 Nov 2025 20:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763755380;
	bh=4OqO/ugxuEMRtH3V+VD/oAkIwrAvfovYOwp2JomIRDY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Jpz81HGTtEKDGcKi65MeUIvWFw+4iugoG5VhiQ6/ybZtuTh/hPjk+zeeQaL7O0YH9
	 wqAqQKk9jAJ1GJgmK66K/OBLagH9IEQ50aevYpm9jj8UXxh5dSae66WJM88ECdztT6
	 QZNGOVXqgw7nu9BGrr9KBNzn+w86WmxbEPkk+X7eoeJ/i2OLUpxfrZxPCmjOAo8yM2
	 VOb5OEirlHKYArLwoEZNttmHxmVyq179/fW8jbkKl7BeLory2W0RK2fXgnT5hAuPtk
	 BIjq3T02wBeWhP42B2sL0Vlk33ZuMks9g7QS7q4C1JK6O3i2e1XCYIauXc6DzkpRbv
	 18TqNFAj8k5kA==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Hrishikesh Suresh <hrishikesh123s@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
 adrian.hunter@intel.com, james.clark@linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251120041610.299972-1-hrishikesh123s@gmail.com>
References: <20251120041610.299972-1-hrishikesh123s@gmail.com>
Subject: Re: [PATCH] perf: replace strcpy() with strncpy() in
 util/jitdump.c
Message-Id: <176375537924.3973666.8147842755858554191.b4-ty@kernel.org>
Date: Fri, 21 Nov 2025 12:02:59 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 19 Nov 2025 23:16:10 -0500, Hrishikesh Suresh wrote:
> Usage of strcpy() can lead to buffer overflows. Therefore, it has been
> replaced with strncpy(). The output file path is provided as a parameter
> and might be restricted by command-line by default. But this defensive
> patch will prevent any potential overflow, making the code more robust
> against future changes in input handling.
> 
> Testing:
> - ran perf test from tools/perf and did not observe any regression with
>   the earlier code
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


