Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5CF4AEE0
	for <linux-perf-users@vger.kernel.org>; Sun,  2 Jun 2024 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717360669; cv=none; b=QO4sQm0aZ7EYv6yDwLpYvIbvyWnwTJl85+86k7kOGnZmeqxjuZO78CTMhUp7BRTDlDbLynMACzRpIakChvCG1aTtiuR5WW04H4fpP+gY81qSfR9OcS+cVD7dhYNjSnW+nT7sJhkslaLKuDcwfXfBqx1l37DLgOw4+yxIqTO9a3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717360669; c=relaxed/simple;
	bh=FqEJ/1qCtEHp4QwWgutZI6jDkZHGfucAq7uG6a9ReMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fcp/Hef5AxSJ9QhbpCiquJss34n8crVFAen8RZ8RuoA/1rXW2clJaFQtbWsNKALOEfui4DpFy/LuFnYIlqzUvaj1f6tRLyNpTUFiHD9f48fnylKP52ib5lVjWOMxvCzZvjMpCtH40QBnb5OYTY7rdjupwE93FZBsFn+25JFIwXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BEzEsfKq; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BEzEsfKq"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso4333561fa.3
        for <linux-perf-users@vger.kernel.org>; Sun, 02 Jun 2024 13:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717360666; x=1717965466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqEJ/1qCtEHp4QwWgutZI6jDkZHGfucAq7uG6a9ReMk=;
        b=BEzEsfKq8eNs/+x8BlHE8rQ3cQC6GM8thYLE4wd1yfhwAdU6OTdd2WdctRKa+veCAc
         pg0KBNI7xqc+nt8bBPeblQkJHbpIcXFefCeTQ91t8xrgpEDxyiY3iWVac9Vd1qffKLzh
         5ktxial+GGvw70XivvyleyS8IGfogqcAEkGR7Hr7t++sIQga/8x8u4PKAJTQZ6P8zFQ1
         ZdUj3qDVAygUkf3+bn7tpJvWr4u9mYwt04CLWfrE+DCFgvf3NY2DWOVJgXfNBS1hKeJI
         JK0FCtKuZbShJ8edZoBJOMyhnTpMh/t34brsrU5wuXCygPMZIVQrimfu9Tbx4ex11x2U
         BYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717360666; x=1717965466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqEJ/1qCtEHp4QwWgutZI6jDkZHGfucAq7uG6a9ReMk=;
        b=fkX8rBTNxLWDF3zPL3JJaM0k3rViUWnwyNiGgfnUo4G+PO36wxE0JIVzd5s++Rhr8b
         y7X+ehjf1BG9rA8FwDtU7Q8SW8Qug8m2oFvbYPuKBibRO/2if5C8COFXAbPNsU8nGVGj
         liUdhGFA/upYU1LX9cBFKG6w5qPlzHZQ7EzSwRgZ+7zGVWGMpR924sDhPuyObNmUHD56
         SQhR3ik4vdTcqWqNE5AKjcBW2kGiAlCs8cvWBJwG2TpxCN69yA/TONk5jb+Quxim+ZAC
         fJBtLcics4a8Lckn95JVb0pU9aDb75dGgrQSCXBqKqhG1grBMXopUFpEJRrg+qWhOYJb
         x0/g==
X-Forwarded-Encrypted: i=1; AJvYcCWm5aZFGOrdkwMr1k9WACQQix89ps9sYvCxf/2sP6YDT66bII/girx7GVkYvKqqTvWIHpBzTWMzsC4hju8GAGIgkzKAlAaIsEt221z6CuWwaw==
X-Gm-Message-State: AOJu0Yz3UYeUZrtdofr7ymPtanIL3775ETBvFPzrt8pgRvm/Zs1AgAGi
	b9/akpmZWPUsrO+1Z4JZOanmcMiBlnFcbaM3dwiEke7Syw8e10TVcFfKz7CjqQ==
X-Google-Smtp-Source: AGHT+IEjNe84eQj1gn88SfF3BFLZAgu80JypGnsuOUMGs7rx88Xac3FjV8Xp7A/45iVIt6uwtTP8sQ==
X-Received: by 2002:a2e:a99b:0:b0:2e0:37be:b70f with SMTP id 38308e7fff4ca-2ea95160333mr54516941fa.26.1717360666210;
        Sun, 02 Jun 2024 13:37:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:138e:9906:1038:1841])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eaa8ca91a8sm3593471fa.61.2024.06.02.13.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 13:37:43 -0700 (PDT)
Date: Sun, 2 Jun 2024 22:37:38 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, irogers@google.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v7 1/4] perf report: Support LLVM for addr2line()
Message-ID: <ZlzYEp78ihsGeEEi@google.com>
References: <20240526182212.544525-1-sesse@google.com>
 <CAM9d7cgf1ZqGGCHU=g8ksfigWhL-XPL4qJiHzz+EQ6vo5c8DyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgf1ZqGGCHU=g8ksfigWhL-XPL4qJiHzz+EQ6vo5c8DyQ@mail.gmail.com>

On Thu, May 30, 2024 at 09:58:09AM -0700, Namhyung Kim wrote:
> Can you please add something to tests/mask so that
> we can test the build with and without libllvm easily?

I have no idea what this is (it doesn't seem to be a file or directory).
Do you have a pointer where I can get more information?

/* Steinar */
