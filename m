Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB365347C7;
	Thu, 30 Oct 2025 03:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761795977; cv=none; b=reu8TdmKMxsuuyM0gxRrZbDlw1f7eVLuzHIWJplElYTy4KdAXsF07v/jpZTJgPTq0W7PfALZujyGvOWesF2L+C6syfNZ8jx85xxfHddoQg7y3/lv98RQAWLnmC86yAtWAudBvarkB6kLxOzrIGovnN1Ldcgj5AwruxBkzpPJZ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761795977; c=relaxed/simple;
	bh=7Jsln25WpDAdawB4lW1ak1iJi4YJWKII1x0JtntDvx8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R9EABhkoMczKargueNlTEnimb9+x/WUMcLP++1RALpxCv5eHVH4COzZYK4ABjdWoIM+RdacSb4dFBGNaSmg83udKW+BtrJNFOOoKXwpX4eXcpzI7rRTEkxnNznaMh9i5XFXCQwD1+vW6JXsGVNpt/LYKzf2mqOonkA98mE/h3yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8dZMtTY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8dZMtTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A08C4CEFD;
	Thu, 30 Oct 2025 03:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761795976;
	bh=7Jsln25WpDAdawB4lW1ak1iJi4YJWKII1x0JtntDvx8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Y8dZMtTYHZrHkuXSUhkMPhP4Iax4d3ShSOqaHSVwQE3/zHyVhMOYaDzey73M4/iM1
	 vOfgMry95dg3YTX9s9hq6QOtG1j4uoJly/u4hxVpVBOuplhqTUIzDc15KvQ039tetz
	 blIXiD4nVYjgZ2xaNKDbsKzTWQC4wg3zBeytRzsPqKHXNPD2FbouaJEvudhc4hQ9D4
	 yvOzooM0msr8SIgGjpNxzlDP0gifDiSpvY0JQwKS7/frJOaOhwDzjJ87x1QTv2Ss3i
	 k76uE4H2SOEZHiyHNrpRr4WcaWaakspbf7z+psvB0uOA7lB1HQV/WLPdK/72V0gefz
	 2bx04BfN6aURQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, Michal Suchanek <msuchanek@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
 Tony Jones <tonyj@suse.de>
In-Reply-To: <20251022103839.19550-1-msuchanek@suse.de>
References: <20251022103839.19550-1-msuchanek@suse.de>
Subject: Re: [PATCH] perf hwmon_pmu: Fix uninitialized variable warning
Message-Id: <176179597561.3104145.7271350942005673557.b4-ty@kernel.org>
Date: Wed, 29 Oct 2025 20:46:15 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 22 Oct 2025 12:38:35 +0200, Michal Suchanek wrote:
> The line_len is only set on success. Check the return value instead.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


