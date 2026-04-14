Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A917D3ED5D5;
	Tue, 14 Apr 2026 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186720; cv=none; b=Cqt6p0+Aa4ir4eG5MpH4Ty87K5G4/88B5At7vPalGhAHS8VehoZVukhH1I0hYV61rp14fx21iEdeJ8/lQHmXSXNxi6Sfa2sdswmJTEzByZx0CpLju5k/17cTCKnCSAEzHvddqS0wrM3W03Ndj6dxtTq8Dc0DYojAyzoK725kj8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186720; c=relaxed/simple;
	bh=D5x1HuD626T7gLjsRo+8+35Npdw4cU0pn21f5dNipow=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b9gtf+GDQ5WcnwMiZnBog18vjoXuVLAgZLFWDzqpzmv52wrVwh11j4BU/mizz+LcsI1MVHtvC4Qb1h5HHsHZUfQJqxIJ/W8flcT54G4XvfhcMK/+ji7ewzI5G3Ikj75JGE/XHVgNN51wSgld7QabKt00m9izAy/qu6n8iaIdnMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tc/JMPjA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tc/JMPjA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B271FC2BCB6;
	Tue, 14 Apr 2026 17:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776186720;
	bh=D5x1HuD626T7gLjsRo+8+35Npdw4cU0pn21f5dNipow=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tc/JMPjAD4D+7sfJNdADRIdZmeCq4iq5nOhio5pJqxp/fzfLotCT6hcWaSncK2vs+
	 0QYW+8/3v///OzRcglYK5grOkg6EQ5oZuY5IwqK4F2d2OsLF8EP/YnJ6hXnC18oS2l
	 vKd0ZdTtoDC11kFqQVKWTEDdPIXUkwExgdW7sC7YhKw9yC4o2DcXy1pJkije9B2Umg
	 BHPctRclvBmI/ragmR5xAVTY17KK9MM7E9+mFpIT4NeWS1cg8sA+ve51eWB6kpljpW
	 51nFu9VKpn5L1eNIvNZfuwoVV3qUz3Xy4wMVf2RcfW0Efp1R7821pkYKE4aPRxxU9C
	 4ZlhuYOMlHZfQ==
From: Namhyung Kim <namhyung@kernel.org>
To: james.clark@linaro.org, Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
 alexander.shishkin@linux.intel.com, german.gomez@arm.com, jolsa@kernel.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 mingo@redhat.com, peterz@infradead.org
In-Reply-To: <20260409000216.196083-1-irogers@google.com>
References: <CAP-5=fUgSTa1+m6PXLm6JSxTcvEbZymwwDKqiV_X+OwcKXga9A@mail.gmail.com>
 <20260409000216.196083-1-irogers@google.com>
Subject: Re: [PATCH v4] perf test: Fixes for check branch stack sampling
Message-Id: <177618671968.1519819.6822107268454486821.b4-ty@kernel.org>
Date: Tue, 14 Apr 2026 10:11:59 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 08 Apr 2026 17:02:16 -0700, Ian Rogers wrote:
> When filtering branch stack samples on user events they sample in user
> land but may have come from the kernel. Aarch64 avoids leaking the
> kernel address for kaslr reasons but other platforms, for now,
> don't. Be more permissive in allowing kernel addresses in the source
> of user branch stacks.
> 
> When filtering branch stack samples on kernel events they sample in
> kernel land but may have come from user land. Avoid the target being a
> user address but allow the source to be in user land. Aarch64 may not
> leak the user land addresses (making them 0) but other platforms
> do. As the kernel address sampling implies privelege, just allow this.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


