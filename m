Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62221157A4D;
	Fri, 28 Jun 2024 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593730; cv=none; b=MgAitVoeiXpK95ihTL/s8I24H448e74JCv1a48QiLL8jlG4xBsBqogeFkfSvuf0e1jvQMeBEzu8Zp+eO1b9/B3KLZvPa4RJvuhXMBM4Puri03Wg4nUBWWcM3iV1mZX49jO9ZDm6N0n5E1qnaZXuIuzQzL3Uy94x6hEX8SgUDzto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593730; c=relaxed/simple;
	bh=PdtVANYrctrqBCWwv7ov4lV+6JM4za0XB1mLtDqcKb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvTfK/D8qg0R+Wb//hX2tnvFbUwMfN7qQKLOdDNt2BNAmszuODCFAuZGlvSzro4AK3cXYZMZ/pqngdyc269beq/Y58EW7gIfOdWWPbdeIoE79Hwn6TMT6acjHvgvzf1Gjy/E4Wci1QQMBjRva9SHDC1Y++elz3NultS9S+sT0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8nOEbwZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8nOEbwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F43EC116B1;
	Fri, 28 Jun 2024 16:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719593730;
	bh=PdtVANYrctrqBCWwv7ov4lV+6JM4za0XB1mLtDqcKb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8nOEbwZiv9U/FhaA/M9kX/5+9XP2zYEVMEjjF5lN/ZHUOA9Fh2NiddbPVutlITdR
	 vnY7xi05PDWGYOzZynaF1DnSF8NVVwDZeFoTbd0t3eOBdlXjD9lXIUzdgXK0GBN4H4
	 arJjtIk3wz+P3JrULoSIDUdVqs+LrTzbt8KrgeP5P721KL7N5R1O37rRv0uOTSgwC4
	 0hO/ABmmjR/ygxwXlVB6CTmYtaQl1VgIzERy7MR49pcQpPkZ5WnYnC4f94BUAJpH0z
	 XDETqyzPsqFVyLASVg7CIRFKPlTdqDKF9RQ87IBeKftAliwzs5i/xOjT+qoo+aMz7B
	 Eq9qxXXk6q1tA==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	James Clark <james.clark@arm.com>
Cc: robin.murphy@arm.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf pmu: Event parsing and listing fixes
Date: Fri, 28 Jun 2024 09:55:28 -0700
Message-ID: <171959369425.545185.4436181413717608549.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240626145448.896746-1-james.clark@arm.com>
References: <20240626145448.896746-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 26 Jun 2024 15:54:44 +0100, James Clark wrote:

> The second fix is related to the discussion here [1].
> 
> The first fix is unrelated but I just noticed it while fixing the
> listing issue.
> 
> [1]: https://lore.kernel.org/all/ce31a50b-53db-4c6f-9cb1-242280b0951c@arm.com/
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
