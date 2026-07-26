Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6394233ADAE;
	Sun, 26 Jul 2026 05:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785043439; cv=none; b=X8UGUSyCWcQwR0mIO4o5V3tzBdGa+EmFRFwsT3ElFsIAMvJkmiyqAFt4xnFtsk3I0cGHvTVG4JodaSeMjglTPfgtxc1PPU07wo/yvTUiQ6VmcbB1VnnmFtOAWGqxurjS19xA6M9FDFZ/ANMImQlsDXJoaa5Fcp5PKMD6kHWx+io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785043439; c=relaxed/simple;
	bh=UOw8vP3QZakTJIPjQzzmin51BjW64yMB4mQwbQQliZ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VJ6ofQ0Sh7EggX8G52rdv5Oh0KC2kKtKlVmKBHT+9v1Q9jZGRstn49c4RpTsJcACRRGGtHyZj0rn1euzlzMekEytWJtAyWuFBIdpAERn0jmYkWvJddcXWdIMnzRYpeV9iX3O9RftbPArFSt/whgbyljvyWKY0Bjaww06NuKEgpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMS/GCxB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMS/GCxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4A11F00A3D;
	Sun, 26 Jul 2026 05:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785043438;
	bh=qucJEBm7vZSSwutZyNmgjMwBeqIaYeuPJiulP1fBmwI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZMS/GCxB3AC81oMjQJmC/C/9fxQ2Qw/tRTrrRpV2vJ946OQwpxJ5cSOkUrGfNgYQ1
	 eEX24Rjp2cctiClOrVgAAJeI7JQ9b5JJF1PYsvxOJhqcJOAxTCLyfOyZJNr6J2RlYA
	 4LVrMeqKxo2G1mx6lefVQALQy+jV+fBVJMT25pO9O/usV+kPxgkF0u8a8YdrOJOKUr
	 iuZOGYisXq1xeTGwF8jXOiJ174Icp929/3+xkutki34IeD3G92UpdOj11WCPQlJJbf
	 TquHE3572GnH8BYKf8cNI93ioH1weWOpy+iwIDuqJak7ZvhLPO1cEwvAsdYUvegMVj
	 5KGDdNazoiElA==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
 james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com, 
 chjohnst@mail.com, sean@ashe.io, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260719191000.441985-1-atomlin@atomlin.com>
References: <20260719191000.441985-1-atomlin@atomlin.com>
Subject: Re: [PATCH] perf trace: Format instruction pointer fields as
 hexadecimal
Message-Id: <178504343772.1075259.737686604260940495.b4-ty@kernel.org>
Date: Sat, 25 Jul 2026 22:23:57 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sun, 19 Jul 2026 15:10:00 -0400, Aaron Tomlin wrote:
> Provide a helper function trace__field_is_ip() in
> trace__fprintf_tp_fields() to ensure that tracepoint fields representing
> instruction pointers such as "__probe_ip", "caller_ip", and
> "call_site" are always formatted as hexadecimal memory addresses rather
> than signed integers.
> 
> For example, when running a kmem:kfree tracepoint:
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


