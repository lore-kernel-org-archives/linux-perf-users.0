From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v2 1/7] perf script python: remove mixed indentation
Date: Wed, 6 Mar 2019 18:09:34 -0300
Message-ID: <20190306210934.GM30734@kernel.org>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-2-tonyj@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190302011903.2416-2-tonyj@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Mar 01, 2019 at 05:18:57PM -0800, Tony Jones escreveu:
> Remove mixed indentation in Python scripts.  Revert to either all 
> tabs (most common form) or all spaces (4 or 8) depending on what 
> was the intent of the original commit.  This is necessary to 
> complete Python3 support as it will flag an error if it encounters 
> mixed indentation.

Thanks, applied.

- Arnaldo
