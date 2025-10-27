Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFB92D8782;
	Mon, 27 Oct 2025 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761589356; cv=none; b=JAX+9oC0z+SX52Mj3UeDtxT6JEweSV3g8/mZXRFC4GTWm2qETDScdtRXbj6ov0lf4S5lw0ssC0/eIFEoZ7HN5ijGIA0hJRrFAf4EgfOgutr2f5+Ckzz4Ku13/q6b7FoVSb3Fketw7TXHKqN2QAc27gVtcxr0GdNlA5i4dZPsp2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761589356; c=relaxed/simple;
	bh=Iy+GSFg3ZbtIoV9QLHASXqZgjcFJcx2HdvzwEmqf4eM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F5KRcJJUiXl6FnR2Gq6Yc1mOM+NHqCfamTSH6O1k0bjsw6PLeMDdPYeRnAfKZLtDVXVlGzXJf8xsafgBXPN4OWqrjWYKSyS6GUOiyXQlHH0Wq22R+7PstPd1wYc3wBS1n05SRRAA4pVTs9UXnoRQ2IfkCvEQ9czwetuhvBdS85s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DntHTOpY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DntHTOpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DBBC116C6;
	Mon, 27 Oct 2025 18:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761589356;
	bh=Iy+GSFg3ZbtIoV9QLHASXqZgjcFJcx2HdvzwEmqf4eM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DntHTOpYFd+1jzAJ6ga+6ponbKIn9xs1ClgJM3GgG/6M1M0PlNS2H42i1IjlgZgte
	 l3F/OtyrhvqULGb/UbYZigNzwjkr9pzMGn+Y0/Ie1PhVuCe9MmQ/Q0OTObChUr64VJ
	 bilsw43ldyp4/1FRWYoUAC+GBD1eQQa0b2NfYjkhQYuG+zsMmlHczOYqtv5PVBLG13
	 DTrstLY/iML5ltPNBv/TIahA00MShuJJJWfGLwWjr99gZoLjbNsJNNwnXzBsW2yHOS
	 WGoIG2nolRmAXxg4eNsFrE4u5wTNKO7WPJ/FsMyy+O+w2BUGPKyqWCn/QM3ufaY30W
	 vbHzJa+JzjwDQ==
From: Namhyung Kim <namhyung@kernel.org>
To: leo.yan@arm.com, adrian.hunter@intel.com, mingo@redhat.com, 
 tanze <tanze@kylinos.cn>
Cc: graham.woodward@arm.com, irogers@google.com, james.clark@linaro.org, 
 john.g.garry@oracle.com, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 mike.leach@linaro.org
In-Reply-To: <20251024085625.175688-1-tanze@kylinos.cn>
References: <20251024085625.175688-1-tanze@kylinos.cn>
Subject: Re: [PATCH v3] perf auxtrace: Add auxtrace_synth_id_range_start()
 helper
Message-Id: <176158935603.1688092.10910536253169366215.b4-ty@kernel.org>
Date: Mon, 27 Oct 2025 11:22:36 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 24 Oct 2025 16:56:25 +0800, tanze wrote:
> To avoid hardcoding the offset value for synthetic event IDs
> in multiple auxtrace modules (arm-spe, cs-etm, intel-pt, etc.),
> and to improve code reusability, this patch unifies
> the handling of the ID offset via a dedicated helper function.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


