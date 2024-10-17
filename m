Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2341D2F73
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202200; cv=none; b=FShx5hUf+cZKJQgecbpHqLNWVSVi0lFwpCTXsw2POVPE88uxYqLz8gU2HXMSF0jcD1AhDq5SZvNvhgcirrjSl9/Xh+lRMU3ftaIVnPsc569C/KNtzuo87UhZzDP/wJ+AJLsOtXDspVPXwT3pXyv5EfJIbEBtf6zg0nQRg0EBAUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202200; c=relaxed/simple;
	bh=mo2jTF7N7v5MtI+TDxwjmjTcOP33Td8wIoGqTahSdyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgrqfbGCSynK2I/TV6qCLDD2BpI4q1nMmzqerSI00K5eYMWjphHWmpp7KfQs15FL83scdcfGEAy8Fmu5h4dyWA5ooB5gug6aB2qr9nsTSNoAGhVaa3FA9u09eWpxsu2GcNwlg/1/SMzY/lpS9aQOCnewQp4WyemfcudseEphfao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5677EFEC;
	Thu, 17 Oct 2024 14:57:07 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4527B3F58B;
	Thu, 17 Oct 2024 14:56:37 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:56:35 +0100
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Steve Clevenger <scclevenger@os.amperecomputing.com>,
	james.clark@linaro.org, mike.leach@linaro.org,
	suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V9 2/2] Adjust objdump start/end range per map pgoff
 parameter
Message-ID: <20241017215635.GB1231367@e132581.arm.com>
References: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
 <6107521c4fb1d4ba2da57a6d81c17b54f259feac.1728599785.git.scclevenger@os.amperecomputing.com>
 <d9cb2018-1f68-4aa8-b795-dfbad5e1be37@arm.com>
 <ZxFXNkaoGqnax_yV@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxFXNkaoGqnax_yV@google.com>

On Thu, Oct 17, 2024 at 11:28:06AM -0700, Namhyung Kim wrote:

[...]

> > When applying patches, I found the prefix is missed in the subject:
> >
> >   perf scripts python cs-etm: Adjust objdump start/end range per map pgoff parameter
> 
> It could simply be "perf script cs-etm:" but it's up to you. :)

Yeah, this is fine for me.

Thanks,
Leo
