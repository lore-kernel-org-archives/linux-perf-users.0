From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/2] perf record: Support s390 random socket_id assignment
Date: Wed, 13 Jun 2018 16:55:56 -0300
Message-ID: <20180613195556.GD2686@kernel.org>
References: <20180611073153.15592-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180611073153.15592-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Jun 11, 2018 at 09:31:52AM +0200, Thomas Richter escreveu:
> On s390 the socket identifier assigned to a CPU identifier is
> random and (depending on the configuration of the LPAR) may be higher
> than the CPU identifier. This is currently not supported.
> 
> Fix this by allowing arbitrary socket identifiers being assigned to
> CPU id.
> 
> Output before:

Thanks, applied both patches in this series,

- Arnaldo
