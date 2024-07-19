Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4418BEE
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401235; cv=none; b=dAjgXP0SoU9rqKRwQJQdlUZetwNawC6ZCXVyILf18GDGKdyskCYbJQZtXXQcZS6byD7Rsg6RUsr4Zc9sPjfT6jkr52CaNJqJtJ13hrEtV5iuhBUHaTmxDVHgDqC2chZfjeOMdkEisZLnjtQD8zrn+TDPZkw63OKagQDGwaajZqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401235; c=relaxed/simple;
	bh=vWCSbsU1XiXsT7ggfUaReKVlggtTXhHF8caKHa70JoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IO8xgk2orGh1dT1svHgxVZL5sllSEG1r1xRcu8Wo8fKtLxXnsDVaPH/RZ/R2i1dDF1NY+JrroQKiQfCHspARyQlLq9wM//H/8oSLPqsSLSMbhwlG3e/+XQYRKzo5JKwJw7oh3Cji6lIqBQXwRFgUmmARp2lJyxntjjfxvcdiK2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jr6HWFY/; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jr6HWFY/"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso2505003e87.2
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 08:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721401232; x=1722006032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j9/NGeS6mThz3HtAEXN5PjNm55RGh88EEnlYEhKoQIE=;
        b=Jr6HWFY/T4gZaRTJ6UM47ymeXKjAIrDof7m1y4VC21JP2Y7NJ6mbBIhw47OrF58nnZ
         4vwdR1f4vv0O66kql6FG/BsJXN8B8uho/Zi5PdRZQLPgb6kCE0M425zGHG3ECuKW3RJY
         DuqrYYM2/pIi5QgQyk82Ydf0tQwhU6OUAB7r8x0s4IM0SlEx/N2HL79EKAK0I+LzgnSa
         jmljCGjHPp1/Cpk5Ps4joVTAeMFt6QsMnOCV0y7eRml2j1kCGUREiNHMPlZUCGEWsEL4
         dZQS7/yThWCU9+77KkxuEpvMWI6gwFRppwITIavyl+wJ6yodAX0GFZKOgCAly5UnWJoZ
         wohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721401232; x=1722006032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9/NGeS6mThz3HtAEXN5PjNm55RGh88EEnlYEhKoQIE=;
        b=gfGJ7dl1x0CQ4beWJX5Z6j9xAskmUunJGquelkTTkjnWLyU4FzrVRv1yw6si0wsw+e
         cmPSYGj8qvTSR1Gcohg5tPo6ydUCVwqSzEkbYoPssaZhYrjzyMRwK1l1cCe5VJLs3b1m
         3ffzF4zk007zlIkzcpPScuifzbxyRjQx55sk3qHUjBJcGME06QRSZOyMcKvgAeikCm8F
         h8RVDVLEm4NXMetjnWk4fIJkPQUV5vWfTF5OEdEnVSm09PQsMC1bo7A5zosuzgKJpXvh
         zW0vsup1zvMLgws/rW5MXXkcjw8imWXgfF0hU0FQaWFcIcbTcAP4RQb5gu2ZVrrCttlD
         5goA==
X-Forwarded-Encrypted: i=1; AJvYcCXCk99j44RtR9Li2N0ygkLt1ghUe5tVXkt8zACAVvFYphNTzeZbzfaCucmy2kgAW3Pb3jneGsM7h/4MsPvHD5i0ec+RRcclatkCxaaoXbo04w==
X-Gm-Message-State: AOJu0YxyDzwVnXys0YCnNG+ByqyMTaak1HXeMepnjdPvOfLJxea451E3
	GIP8yQUlXxA2mHlfMtG+PkLAwJ9mtrxncNNXZ0k3qEpS6ybd9+7LIbuUuZg6KI4tmHaB9SKAmIv
	5CJqU
X-Google-Smtp-Source: AGHT+IEDqKueVbiVOiOXCiEj8hKu+uISZ2hOAQtwy5TF0WXPgMDc7VxGS9+ARSKcieT6fEkKqKoBHw==
X-Received: by 2002:a05:6512:124f:b0:52d:582e:4111 with SMTP id 2adb3069b0e04-52ee53b6deamr8088293e87.18.1721401231237;
        Fri, 19 Jul 2024 08:00:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:5684:1eca:607a:2a0c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef5581afesm214266e87.308.2024.07.19.08.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 08:00:30 -0700 (PDT)
Date: Fri, 19 Jul 2024 17:00:26 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, irogers@google.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v8 1/3] perf report: Support LLVM for addr2line()
Message-ID: <Zpp_iiovOlsLQmQ7@google.com>
References: <20240602204208.735793-1-sesse@google.com>
 <ZmCi3Z940zDxF487@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmCi3Z940zDxF487@google.com>

On Wed, Jun 05, 2024 at 10:39:41AM -0700, Namhyung Kim wrote:
> Please fix the coding style.  Also you may add a pair of brackets to
> multi-line code even if it's a single statement.

Fixed (I think?). Sending out a v9 also with added build test plus a fix
for /usr/include/llvm-c not existing.

/* Steinar */
