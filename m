Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB381865E3;
	Sat, 14 Dec 2024 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734179678; cv=none; b=bOcvuObMc4xPPJRH/sUOAKcazllvUdSEkTIc5LPEZi/ahV0DDXWBuQHKJmajkmbf4drwRTj56X8mXlA3dIh5n4K1aLKJZYR3vY0vQl16uoNjXxc//WHrRcBTuMS+RpA9jj6pa4P6pV3qmWnoUFeftFJEjRiM5o3rm5ng7ELRG6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734179678; c=relaxed/simple;
	bh=78H29fzUVe8lw3Nwe9b2wWplaMs4cpgkBlXPJtON4Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoJ1rewqgSsnrv1g/dD4V6DrlI92VQisr8WsFvIfKbThE7dDbsjyTbsFbf9kPdyTCw7JV8nn0/82qB0as6dhEG8xDS58TObCg9gh4qRLVL0rqxUecHGY9K2ubyxY/ssJy/D5XAnhNy3fNdX4bhOx1VANxgVyT9jbsKA5lZ1SQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrEYgNSi; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrEYgNSi"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728e729562fso2153293b3a.0;
        Sat, 14 Dec 2024 04:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734179676; x=1734784476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IpMQSSEqsDWvTudVw/h/d6FBK0PDcLc/4pOMNKtw124=;
        b=SrEYgNSiFee8ohNmuf2ypAWk7GKBjp0wymiNyZr4MVUy1oyo81nwb4DLM71TZ+fK6O
         AAIztWVEoJpKCsmWUawtfubMPZcEGjfbNwm5tu1/mbUTWpA2eIpSEYLSxWlZ799jCsIM
         kBqOFvZAcFN876p5SRnt2xP6K46KZA53bHodzfXlzIT4bMB+ZJzRNmeJDw0S+V66MPN0
         Bv98a0+wWjrR/7TxqU8i/u94HTMex0WS93RdYfCJJByoonl1CFsFsgAhGpa7pima/Z3b
         M/MTtsLYaS5MCNlE6nzdR8J6qnjAWY+V2ESryM+LcNe9H+74Ggr8klSwiDKw5M4P7lOe
         9LTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734179676; x=1734784476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpMQSSEqsDWvTudVw/h/d6FBK0PDcLc/4pOMNKtw124=;
        b=MtIFnbcawVkItzolIMCKUEK5iJRezVlQaYgt3jf4CQsfvnm17iVX80xcJTN3Ikkvf4
         th4Xt2BntwWs7Uo/BC2E185QkLlPkoWWMC5/bmi8rdK5FAa15Jg+ly1Vqkqts2xppi70
         c9RX9aVXhpM/7gmZ/92PGp4B/SYIYMNDiSHa2qVOgvwzvgqsf2MaSvsjScSVMI2Vp/dG
         IjoKmRvdiiPCYt2t1TYYUytnVxLs/WCO9QdvY4QFM/J1TdnttDbs4WKH5kvz5vLBN4uf
         KPhli/c7ZZUEZ+pqsXaifgaF93/bV508WLfbaUxQwEkOlmiVS/1L2KoEWqIw/A8O5XJ8
         Owbg==
X-Forwarded-Encrypted: i=1; AJvYcCV39iCKRZfI7b3/23Hd23zJBJhJDqHJHmZ1gdXmKTjeQ80/tLZUxg4vrTL+tK5OQopygbOp1daCJK9idJM=@vger.kernel.org, AJvYcCW4hH8WfI+CsRr7pXUk9KS5v2iJRuv3HVbWypE3iSljY/v++DuZRcb6OLqHy6vPNfN1HMqFwJT3dLmPjebuupgUWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3d8jiBxJ95uQUmkG2v7BwraU0MeSMBq3bEwVVDN2StkFV0oQZ
	I+djIXU8kmP3BaupjsMWQ5Q05p1G0gV6HIw0LcJRGeUKl1cn3wRo
X-Gm-Gg: ASbGnctraOgwpjKj2vn6iVIPwNtVw/qKMszrEIyzm95Gi1d4ilKUt9ZtRJ25Bqnz6ct
	q6dgxyndNP5+d7lmVGpb9N6kmqXYy9D7/7TRlmrRwWgn16Di0i5nphRyGwNF/1IotlYGEAva7io
	b1KPMNBFesmtkd2wkub50JqvDuZHDBfD8YBGPJLpw9UaknH2+i4Er04YPuhPsHbxIEHjBfG+8X/
	EfyZimPo0yY/cRjgB5awxErp599llYgbwEAjrtdCYCb3LBdSHht1CzbUH95ZlHWVXY9MS1OZdf2
	DP4meKfN
X-Google-Smtp-Source: AGHT+IHap2SFr6rgPUn02VkNQfBRJOHMk8Wx/Z+/TpIo8YjTBfzPBOnzTyWjteABVVpVLxFUg9QHaQ==
X-Received: by 2002:a05:6a00:420c:b0:725:df1a:281 with SMTP id d2e1a72fcca58-7290c155379mr9290645b3a.10.1734179676622;
        Sat, 14 Dec 2024 04:34:36 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad5670sm1335796b3a.70.2024.12.14.04.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 04:34:36 -0800 (PST)
Date: Sat, 14 Dec 2024 20:34:31 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 5/8] tools headers: Add non-NULL assert to container_of
Message-ID: <Z117V4kXau6bHTRj@visitorckw-System-Product-Name>
References: <20241213210425.526512-1-irogers@google.com>
 <20241213210425.526512-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213210425.526512-6-irogers@google.com>

On Fri, Dec 13, 2024 at 01:04:22PM -0800, Ian Rogers wrote:
> container_of on a NULL may yield a non-NULL, confusion and errors.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei
