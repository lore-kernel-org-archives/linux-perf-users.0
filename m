Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05F218891F;
	Fri, 23 Aug 2024 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422669; cv=none; b=LegNCFKGCPGJvIcou2dR6MhJLOjHTPIMTeOceDNHR7FGek+rid2ahE/Hp2KyPpp7+7a/GiF4JoULx5SPb9yqPhUD6z2IuqBEkaoGyR7n9IOqv5LjCWWbdkT0P2Qvt+oKNRB0zZORJ9ribo+FzSmW+hwGYZg/ebLHx6ZxRpIkl+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422669; c=relaxed/simple;
	bh=wHlt4GxoloEkDK4kdrterkALazfmKQQHPbiEsnSLKyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ed0irfD6IBeu8gmz/pTNqOb6a0LFK4fXnVW5/X9g6r5x1jIYULKLRs4KgCrNyPmSz/PLbm6hBokMX4MAAWcnMwFHBTxL5jsxWPd2cOIAn5M9M5WoUIVO3vofiBTgQzuyAoF2ztTWyNVAQERWh1FMGwqzQlPKeYcgM5v3+7ipD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXO2Ur31; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXO2Ur31"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7838C32786;
	Fri, 23 Aug 2024 14:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724422668;
	bh=wHlt4GxoloEkDK4kdrterkALazfmKQQHPbiEsnSLKyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KXO2Ur31Rwj7yblizMR4EH8faq1fjq8sNGa2mFEOAsfJOQxbUZv+Oy56txrVTwePX
	 TCPPHlMbD7IHUTdMZv4baqN2oF9KQsdYZFEs8PkMxHIb11eQ7EA2WpD7k6pjqqgKJ5
	 3/i2/uC3tFIx8KkjdwiqEDZ48IGZhORAdBpFWZSAY15RqVIERPcAuJ/Jc3999DT2Vu
	 KqDO7vCTrtI+eoF3LrNhbBxjn7r9E/i4+m0zE3cyyPyzQvVfMweanVSLNCAAoz64qC
	 /cvBYPTqZlLuErgzp5o8Jvh2FyI4ROIXzivAP9jlWAp5f+4XG4uqXlSh0aj0zemp1b
	 jqsPOj4akhUVA==
Date: Fri, 23 Aug 2024 11:17:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] perf trace: Pretty print buffer data
Message-ID: <ZsiaBnd5KrkGbZ9w@x1>
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-8-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815013626.935097-8-howardchu95@gmail.com>

On Thu, Aug 15, 2024 at 09:36:23AM +0800, Howard Chu wrote:
> +#define MAX_CONTROL_CHAR 31
> +#define MAX_ASCII 127
> +
> +static size_t syscall_arg__scnprintf_buf(char *bf, size_t size, struct syscall_arg *arg)
> +{
> +	char result[TRACE_AUG_MAX_BUF * 4], tens[4];
> +	struct augmented_arg *augmented_arg = arg->augmented.args;
> +	unsigned char *orig;
> +	int i = 0, n, consumed, digits;
> +
> +	if (augmented_arg == NULL)
> +		return 0;
> +
> +	orig = (unsigned char *)augmented_arg->value;
> +	n = augmented_arg->size;
> +
> +	memset(result, 0, sizeof(result));
> +
> +	for (int j = 0; j < n && i < (int)sizeof(result) - 1; ++j) {
> +		/* print control characters (0~31 and 127), and non-ascii characters in \(digits) */
> +		if (orig[j] <= MAX_CONTROL_CHAR || orig[j] >= MAX_ASCII) {
> +			result[i++] = '\\';
> +
> +			/* convert to digits */
> +			digits = scnprintf(tens, sizeof(result) - i, "%d", (int)orig[j]);
> +			if (digits + i <= (int)sizeof(result) - 1) {
> +				strncpy(result + i, tens, digits);
> +				i += digits;
> +			}
> +		} else  {
> +			result[i++] = orig[j];
> +		}
> +	}
> +
> +	consumed = sizeof(*augmented_arg) + augmented_arg->size;
> +	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
> +	arg->augmented.size -= consumed;
> +
> +	return scnprintf(bf, size, "\"%s\"", result);
> +}

Simplified the above to the one below to avoid using multiple buffers
and copying around, now testing:

+#define MAX_CONTROL_CHAR 31
+#define MAX_ASCII 127
+
+static size_t syscall_arg__scnprintf_buf(char *bf, size_t size, struct syscall_arg *arg)
+{
+	struct augmented_arg *augmented_arg = arg->augmented.args;
+	unsigned char *orig = (unsigned char *)augmented_arg->value;
+	size_t printed = 0;
+	int consumed;
+
+	if (augmented_arg == NULL)
+		return 0;
+
+	for (int j = 0; j < augmented_arg->size; ++j) {
+		bool control_char = orig[j] <= MAX_CONTROL_CHAR || orig[j] >= MAX_ASCII;
+		/* print control characters (0~31 and 127), and non-ascii characters in \(digits) */
+		printed += scnprintf(bf + printed, size - printed, control_char ? "\\%d" : "%c", (int)orig[j]);
+	}
+
+	consumed = sizeof(*augmented_arg) + augmented_arg->size;
+	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
+	arg->augmented.size -= consumed;
+
+	return printed;
+}
