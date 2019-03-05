From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 1/7] perf script python: remove mixed indentation
Date: Tue, 5 Mar 2019 12:39:53 +0200
Message-ID: <c31ce5ee-8767-2ae2-17a5-9889c96e1047@intel.com>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-2-tonyj@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190302011903.2416-2-tonyj@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 2/03/19 3:18 AM, Tony Jones wrote:
> Remove mixed indentation in Python scripts.  Revert to either all 
> tabs (most common form) or all spaces (4 or 8) depending on what 
> was the intent of the original commit.  This is necessary to 
> complete Python3 support as it will flag an error if it encounters 
> mixed indentation.
> 
> Signed-off-by: Tony Jones <tonyj@suse.de>

For intel-pt-events.py

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
