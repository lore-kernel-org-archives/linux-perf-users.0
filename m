Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF7B269CFD;
	Thu, 13 Mar 2025 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883376; cv=none; b=Zaha9UcLJKKuS4Dx5oheTVh4VsFb6tp+EQnVRZ7U0HLJgkUJO2IuYjsGmV/BBdURruLTPUW1DOwgNYhp+iaaWRPFd0tH9Tg8xzSeg4Qiz3VQ1gp9tRJVk3itNUO45p7v7nP3r83b5R0uk4fsLZj3E5UF7XGqxGBtS8/eptHfNhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883376; c=relaxed/simple;
	bh=vzWPq7yK0bm430FIcRUlro/hdCADIWfu1PUpuybC3f0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pBSykg5lui826s3CmfPwZdWKk8mr5dPA7dyZbxKCAGywSrrWmCIgexqPf3Wahzz+13B52KvdlJkiYBlkCb8cSxSrSsraOM8oOpLBWm2ctA+oNeQGd+3dhAQBv3rWmMmBYtXshgr7l70j3zfOpGFQp5XX53sVI90oK4doJvhKVPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t74SYHsL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t74SYHsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D89C4CEEF;
	Thu, 13 Mar 2025 16:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741883376;
	bh=vzWPq7yK0bm430FIcRUlro/hdCADIWfu1PUpuybC3f0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=t74SYHsLU8EMc8/nbS2teljW4xpMJZdPQ9pv4q+H6XQXwpv52Qh7bTPMbQp3fz2FB
	 w1kGEBqE2XUwxSbjz2Mjj+GYDdXaqnf8nSTQ7KiphxNzgBjri3nmZXjbyYVU1tdOrh
	 0TnAh8zaDRbLfOhpsgzVe0ES0H09in8hY3dozL3XZ7Ff/522Bcp/M0pc+ePkW0+kO0
	 maYG/LSxEnSCac6IQynFlX4pyQOg363VjyTgmwrIt84Qfe53b8Wbx8YkVdHlgNoNWq
	 RnvAyjRZZjWMKth1Csy0OhuQ19s4W2EOz5PupbX6MzDTh5RFlk6+8fYk3vgwot8oqJ
	 HJeNsq/cqmFmQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>
In-Reply-To: <20250310194534.265487-1-acme@kernel.org>
References: <20250310194534.265487-1-acme@kernel.org>
Subject: Re: [PATCH 0/3] Some build fixes
Message-Id: <174188337563.3466761.8273567856341642820.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 09:29:35 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 10 Mar 2025 16:45:30 -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi Namhyung,
> 
> 	Some fixes I noticed while building with my set of containers.
> 
> Best regards,
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


