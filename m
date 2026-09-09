Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797063B7742;
	Wed,  9 Sep 2026 20:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985836; cv=none; b=R08Q9FOuj6FiwqEmg15/kvv2DUWVxU6SWUytdf8OK6c4fLXOqX9RuxsJ115sC5BuVW0w3emcpOVy6DlhYa5Uus0WHwbhxL/+E82HcroUSpZgijsLgQKk7kUD6edwPsL/azQQzZgn++JaLXI1g0cFcCdZyKmp8JT0DX4XGqNMe6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985836; c=relaxed/simple;
	bh=GDa9doJb5HpYth1oZ4d0wJYLaV5uvEqg1wVw46zNJMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pE8VpZ03cY75U/njkTh3p3UqVU1e62+2oECSo1CX7d4cTBvQMeCtb28JK3tzOhQ1Aj+/JHfl8B5AppfjBLhxh4IcjYiwbqGBoHHm9qtkktJNpatSlA96X0z2rKimqtSjHf4aswom8S5HpaOKmYTrSgfLoeEDhTs6ozyS4vRQSLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jj4fjrEj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jj4fjrEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3791E1F000FF;
	Wed,  9 Sep 2026 20:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985831;
	bh=Zm6OYF7UGpRoKIJEPn08vsmxH3kEkHKLnqQecML+z9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jj4fjrEjUHS0z/G6x7A/HojE9rKD5+CTpyAxnbQiU8t0xVC9Mi8twt57g5064GLYX
	 ngDTY60fS2cbLp1kwO8H0xel5Xgg3e9eSfFMsP11cjP7pVkp82CXnYA96ZsbFKAokF
	 Sr7Dk13mK2jaxWCsBFfYr/YFxa+3OYngB/ducbRujIZg0owYYuPBTXdLKTDy6qLRfc
	 xlFks/JxckiqCwtFr0EjvS0CrhmPIFsBELrLID9/ULzsegBUwOeh+8F89ESxBvm3Eo
	 3vVJXFqu4Qeptam3W4UrzY1AYnERMKVtJNCYD1qGB3bdL4HDng9074KEpqH/lXsOfX
	 0xAXfy+EdNHxg==
Date: Wed, 9 Sep 2026 17:30:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: alice.mei.rogers@gmail.com, namhyung@kernel.org,
	adrian.hunter@intel.com, jolsa@kernel.org, laixintaoo@gmail.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v4 0/2] perf python TUI report and flamegraph
Message-ID: <aqHB5PahbbxmXBO-@x2>
References: <20260809041638.2402705-1-irogers@google.com>
 <20260809051820.2436530-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809051820.2436530-1-irogers@google.com>

On Sat, Aug 08, 2026 at 10:18:17PM -0700, Ian Rogers wrote:
> Implement a perf TUI using the python textual module. Using the
> textual framework means that in most modern terminals the mouse is
> supported, the color scheme can be configured, and screenshots made.
> 
> The work is dependent on the extensions to the perf python module
> merged into perf-tools-next such as commit 88439191ad5e ("perf python:
> Add callchain support"). It is also dependent on the python textual
> module for TUI support.

Cool stuff, just tested it :-)

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
 
> v4: Fix typo of profle to profile and tweak argparse command
>     description to only mention flamegraph after that support is added
>     (Sashiko). Sashiko notes a high severity issue because the script
>     depends on perf Python module extensions that are already
>     merged. This is because Sashiko is testing the changes against the
>     perf-tools rather than perf-tools-next. Verified
>     rich.errors.MarkupError don't occur for kernel DSOs, primarily as
>     there is always a space after the square brackets.
> 
> v3: Tweaks to commit messages (Sashiko).
> https://lore.kernel.org/linux-perf-users/20260809041638.2402705-1-irogers@google.com/
> 
> v2: Migrate from inbuilt perf python interpreter to perf python
>     module. Improve the flamegraph performance. Use the textual's
>     color scheme rather than red and white.
> https://lore.kernel.org/linux-perf-users/20260808065743.2328212-1-irogers@google.com/
> 
> v1:
> https://lore.kernel.org/linux-perf-users/20250725082425.20999-1-irogers@google.com/
> 
> Alice Rogers (2):
>   perf python: New treport script
>   perf python: treport add flamegraph support
> 
>  tools/perf/python/treport.py | 561 +++++++++++++++++++++++++++++++++++
>  1 file changed, 561 insertions(+)
>  create mode 100755 tools/perf/python/treport.py
> 
> -- 
> 2.55.0.654.g21b8a5bc05-goog
